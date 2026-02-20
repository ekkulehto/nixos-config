{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.services.openclaw;

  openclawPkgs = inputs.nix-openclaw.packages.${pkgs.stdenv.hostPlatform.system};

  configTemplate = pkgs.writeText "openclaw.json" (builtins.toJSON cfg.config);

  initScript = import ./init.nix {
    inherit pkgs;
    user = cfg.user;
    group = cfg.group;
    stateDir = cfg.stateDir;
    configTemplate = configTemplate;
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

      path = [ openclawPkgs.openclaw-tools ];

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
