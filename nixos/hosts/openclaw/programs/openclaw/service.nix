{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.services.openclaw;

  openclawPkgs = inputs.nix-openclaw.packages.${pkgs.system};

  configTemplate = pkgs.writeText "openclaw.json" (builtins.toJSON cfg.config);

  initScript = import ./init.nix {
    inherit pkgs;
    user = cfg.user;
    group = cfg.group;
    stateDir = cfg.stateDir;
    configTemplate = configTemplate;
  };

  hardening = (import ./hardening.nix) { stateDir = cfg.stateDir; };
in
{
  config = lib.mkIf cfg.enable {
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
            "OPENCLAW_STATE_DIR=${cfg.stateDir}"
            "OPENCLAW_CONFIG_PATH=${cfg.stateDir}/openclaw.json"
            "OPENCLAW_NIX_MODE=1"
          ];

          EnvironmentFile = config.age.secrets.openclaw-env.path;

          ExecStartPre = initScript;

          ExecStart = "${lib.getExe' openclawPkgs.openclaw-tools.openclaw-gateway} gateway --port ${toString cfg.port}";

          Restart = "always";
          RestartSec = "1s";

          StandardOutput = "append:/tmp/openclaw/openclaw-gateway.log";
          StandardError = "append:/tmp/openclaw/openclaw-gateway.log";
        }
        // hardening;
    };
  };
}
