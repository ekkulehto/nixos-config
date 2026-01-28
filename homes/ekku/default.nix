{ ... }:

{
  imports = [
    ../../modules/home-manager/programs
    ../../modules/home-manager/packages
  ];

  home = {
    username = "ekku";
    stateVersion = "25.11";
  };
}
