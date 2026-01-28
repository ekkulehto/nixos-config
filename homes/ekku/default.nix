{ ... }:

{
  imports = [
    ../../modules/home-manager/programs
    ../../modules/home-manager/packages.nix
  ];

  home = {
    username = "ekku";
    stateVersion = "25.11";
  };
}
