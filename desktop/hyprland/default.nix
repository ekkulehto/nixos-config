{ lib, ... }:

let
  enableMoonlightAutostream = false;
  enablePermissions = false;

  vars     = import ./settings/vars.nix;
  monitors = import ./settings/monitors.nix;
  env      = import ./settings/env.nix;
  input    = import ./settings/input.nix;
  look     = import ./settings/look-and-feel.nix;
  rules    = import ./settings/windows-and-workspaces.nix;

  autostart = import ./settings/autostart.nix {
    inherit lib enableMoonlightAutostream;
  };

  binds = import ./settings/binds {
    inherit lib;
  };

  permissionsExtra = import ./settings/permissions-extra.nix {
    inherit enablePermissions;
  };
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    package = null;
    portalPackage = null;

    systemd.enable = true;
    systemd.variables = [ "--all" ];

    settings =
      vars
      // monitors
      // env
      // input
      // look
      // rules
      // autostart
      // binds;

    extraConfig = permissionsExtra;
  };
}

