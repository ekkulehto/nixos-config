{ ... }:

{
  imports = [
    ../../modules/home-manager/programs
    ../../modules/home-manager/packages
    ../../modules/home-manager/env/default.nix

    ./wm/hyprland
  ];

  home = {
    username = "ekku";
    stateVersion = "25.11";
  };
}
