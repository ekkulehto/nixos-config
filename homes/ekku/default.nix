{ ... }:

{
  imports = [
    ../../modules/home-manager/programs
    ../../modules/home-manager/packages

    ./wm/hyprland
    ./shells/noctalia
  ];

  home = {
    username = "ekku";
    stateVersion = "25.11";
  };
}
