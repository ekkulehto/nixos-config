{ config, lib, pkgs, ... }:

let
  cfg = config.services.openclaw;
in
{
  config = lib.mkIf cfg.enable {
    users.groups.${cfg.group} = {};

    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      home = cfg.stateDir;
      createHome = true;
      shell = "${pkgs.shadow}/bin/nologin";
    };
  };
}
