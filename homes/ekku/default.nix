{ ... }:

{
  imports = [
    ../../modules/home-manager/programs/common
    ../../modules/home-manager/programs/extra/desktop
    ../../modules/home-manager/packages/common
    ../../modules/home-manager/packages/extra/desktop

    ./wm/hyprland
    ./shells/noctalia
    ./services
  ];

  home = {
    username = "ekku";
    stateVersion = "25.11";
  };
}
