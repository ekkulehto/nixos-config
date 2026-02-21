{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.services.openclaw;

  openclawPkgs = inputs.nix-openclaw.packages.${pkgs.stdenv.hostPlatform.system};

  pluginRegistry = import ./plugins/default.nix { inherit pkgs inputs; };

  templatesDir = ./workspace-templates;
  skillsCatalog = "${inputs.openclaw-skills}/skills";

  # Derive absolute workspaces under stateDir (HOME is stateDir)
  agents = [
    { id = "main";     workspace = "${cfg.stateDir}/.openclaw/workspace"; }
    { id = "research"; workspace = "${cfg.stateDir}/.openclaw/workspace-research"; }
    { id = "coder";    workspace = "${cfg.stateDir}/.openclaw/workspace-coder"; }
  ];

  configTemplate = pkgs.writeText "openclaw.json" (builtins.toJSON cfg.config);

  initScript = import ./init.nix {
    inherit pkgs;
    user = cfg.user;
    group = cfg.group;
    stateDir = cfg.stateDir;
    configTemplate = configTemplate;

    templatesDir = templatesDir;
    skillsCatalog = skillsCatalog;
    skillLinks = pluginRegistry.skillLinks;
    agents = agents;
  };

  # HARDENING: do NOT bake SearXNG IP here anymore (no plaintext IP in Nix code).
  hardening = (import ./hardening.nix) {
    stateDir = cfg.stateDir;
    searxngAllow = [ ];
  };

  # One-shot: derive private-IP allowlist from SEARXNG_URL and write a transient /run drop-in.
  searxngNetpolicyScript = pkgs.writeShellScript "openclaw-searxng-netpolicy" ''
    set -euo pipefail

    if [ -z "''${SEARXNG_URL:-}" ]; then
      echo "SEARXNG_URL is not set; skipping transient SearXNG IPAddressAllow drop-in."
      rm -f /run/systemd/system/openclaw-gateway.service.d/10-searxng-allow.conf
      systemctl daemon-reload
      exit 0
    fi

    python3 - <<'PY'
import ipaddress
import os
import socket
import sys
from urllib.parse import urlparse

searx_url = os.environ.get("SEARXNG_URL", "").strip()
if not searx_url:
    print("SEARXNG_URL empty", file=sys.stderr)
    sys.exit(1)

# Accept both full URLs and raw host:port
if "://" not in searx_url:
    searx_url = "http://" + searx_url

u = urlparse(searx_url)
host = u.hostname
if not host:
    print(f"Could not parse hostname from SEARXNG_URL={searx_url!r}", file=sys.stderr)
    sys.exit(1)

# Resolve host -> IPs
ips = set()
try:
    for fam, _, _, _, sockaddr in socket.getaddrinfo(host, None):
        ips.add(sockaddr[0])
except Exception as e:
    print(f"DNS resolution failed for {host}: {e}", file=sys.stderr)
    sys.exit(1)

# RFC1918 + link-local ranges you deny in hardening.nix
blocked = [
    ipaddress.ip_network("10.0.0.0/8"),
    ipaddress.ip_network("172.16.0.0/12"),
    ipaddress.ip_network("192.168.0.0/16"),
    ipaddress.ip_network("169.254.0.0/16"),
]

allow_ips = []
for ip in sorted(ips):
    try:
        addr = ipaddress.ip_address(ip)
    except ValueError:
        continue
    if addr.version != 4:
        # You can extend this to IPv6 later if needed.
        continue
    if any(addr in net for net in blocked):
        allow_ips.append(str(addr))

dropin_dir = "/run/systemd/system/openclaw-gateway.service.d"
dropin_path = dropin_dir + "/10-searxng-allow.conf"

# If no private IPs, remove drop-in (nothing to allow).
if not allow_ips:
    try:
        os.remove(dropin_path)
    except FileNotFoundError:
        pass
    sys.exit(0)

os.makedirs(dropin_dir, exist_ok=True)

with open(dropin_path, "w", encoding="utf-8") as f:
    f.write("[Service]\n")
    for ip in allow_ips:
        f.write(f"IPAddressAllow={ip}/32\n")

print(f"Wrote {dropin_path} allowing: {', '.join(allow_ips)}")
PY

    systemctl daemon-reload
  '';
in
{
  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} - -"
      "d ${cfg.stateDir}/.openclaw 0700 ${cfg.user} ${cfg.group} - -"
    ];

    systemd.services.openclaw-gateway-netpolicy = {
      description = "OpenClaw gateway netpolicy (derive SearXNG IPAddressAllow from SEARXNG_URL)";
      wantedBy = [ "multi-user.target" ];
      before = [ "openclaw-gateway.service" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      path = [ pkgs.python3 pkgs.systemd pkgs.coreutils ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;

        # Read the same secret env file as the gateway uses
        EnvironmentFile = config.age.secrets.openclaw-env.path;

        UMask = "0077";
        NoNewPrivileges = true;

        # Keep strict sandboxing, but allow ONLY the drop-in location to be writable.
        # ProtectSystem=strict makes the filesystem read-only; ReadWritePaths allow-lists exceptions. :contentReference[oaicite:1]{index=1}
        ProtectSystem = "strict";
        ReadWritePaths = [ "/run/systemd/system" ];

        ProtectHome = true;
        PrivateTmp = true;
        PrivateDevices = true;
      };

      script = "${searxngNetpolicyScript}";
    };

    systemd.services.openclaw-gateway = {
      description = "OpenClaw gateway (system)";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" "openclaw-gateway-netpolicy.service" ];
      wants = [ "network-online.target" "openclaw-gateway-netpolicy.service" ];

      # Put tools + all plugin wrappers on PATH.
      path = [ openclawPkgs.openclaw-tools pkgs.python3 ] ++ pluginRegistry.packages;

      serviceConfig =
        {
          User = cfg.user;
          Group = cfg.group;

          WorkingDirectory = cfg.stateDir;

          Environment = [
            "HOME=${cfg.stateDir}"
            "OPENCLAW_HOME=${cfg.stateDir}"
            "OPENCLAW_STATE_DIR=${cfg.stateDir}/.openclaw"
            "OPENCLAW_CONFIG_PATH=${cfg.stateDir}/.openclaw/openclaw.json"
            "OPENCLAW_NIX_MODE=1"
          ];

          EnvironmentFile = config.age.secrets.openclaw-env.path;

          LoadCredential = [
            "telegram-bot-token:${config.age.secrets.telegram-bot-token.path}"
          ];

          ExecStartPre = initScript;

          ExecStart = "${lib.getExe' openclawPkgs.openclaw-gateway "openclaw"} gateway --port ${toString cfg.port}";

          Restart = "always";
          RestartSec = "1s";

          StandardOutput = "append:${cfg.stateDir}/.openclaw/openclaw-gateway.log";
          StandardError  = "append:${cfg.stateDir}/.openclaw/openclaw-gateway.log";
        }
        // hardening;
    };
  };
}
