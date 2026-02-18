{ ... }:

{
  imports = [
    ../../../modules/home-manager/programs/common
    ../../../modules/home-manager/programs/extra/openclaw
    ../../../modules/home-manager/packages/common
  ];

  home = {
    username = "ekku";
    stateVersion = "25.11";
  };
}