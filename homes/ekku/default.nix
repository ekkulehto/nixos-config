{ ... }:

{
  imports = [
    ../../modules/home-manager/programs
    ../../modules/home-manager/packages

    ./wm/hyprland
    ./shells/noctalia
    ./services
  ];

  home = {
    username = "ekku";
    stateVersion = "25.11";
  };
}
