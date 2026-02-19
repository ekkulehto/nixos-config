{ lib, ... }:

let
  inherit (lib) mkEnableOption mkOption types;
in
{
  options.services.openclaw = {
    enable = mkEnableOption "OpenClaw gateway (system service + dedicated user)";

    user = mkOption { type = types.str; default = "openclaw"; };
    group = mkOption { type = types.str; default = "openclaw"; };

    stateDir = mkOption { type = types.str; default = "/var/lib/openclaw"; };
    port = mkOption { type = types.int; default = 18789; };

    config = mkOption { type = types.attrs; default = {}; };
  };
}
