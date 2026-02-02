{ ... }:

{
  imports = [
    ../../modules/home-manager/programs
    ../../modules/home-manager/packages

    ./wm/hyprland
  ];

  home = {
    username = "ekku";
    stateVersion = "25.11";
  };
}
