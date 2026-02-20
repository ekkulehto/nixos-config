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

  hardening = (import ./hardening.nix) {
    stateDir = cfg.stateDir;
    searxngAllow = [ "10.30.0.103/32" ];
  };
in
{
  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d ${cfg.stateDir} 0700 ${cfg.user} ${cfg.group} - -"
      "d ${cfg.stateDir}/.openclaw 0700 ${cfg.user} ${cfg.group} - -"
    ];

    systemd.services.openclaw-gateway = {
      description = "OpenClaw gateway (system)";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      # Put tools + all plugin wrappers on PATH.
      # NOTE: if you enable Docker sandboxing later, skill binaries must exist in the sandbox too.
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
