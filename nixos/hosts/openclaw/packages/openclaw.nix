{ config, lib, pkgs, inputs, ... }:

let
  openclawPkgs = inputs.nix-openclaw.packages.${pkgs.stdenv.hostPlatform.system};
  cfg = config.services.openclaw;

  openclawWrapped = pkgs.writeShellApplication {
    name = "openclaw";
    runtimeInputs = [ openclawPkgs.openclaw-gateway ];
    text = ''
      set -euo pipefail

      if [ -r ${config.age.secrets.openclaw-env.path} ]; then
        set -a
        # shellcheck disable=SC1091 -- runtime agenix path is intentionally sourced when present.
        . ${config.age.secrets.openclaw-env.path}
        set +a
      fi

      export OPENCLAW_HOME="${cfg.stateDir}"
      export OPENCLAW_STATE_DIR="${cfg.stateDir}/.openclaw"
      export OPENCLAW_CONFIG_PATH="${cfg.stateDir}/.openclaw/openclaw.json"
      export OPENCLAW_NIX_MODE=1

      exec ${lib.getExe' openclawPkgs.openclaw-gateway "openclaw"} "$@"
    '';
  };
in

{
  environment.systemPackages = lib.mkIf cfg.enable [
    openclawWrapped
    openclawPkgs.openclaw-tools
  ];
}
