{ ... }:

{
  imports = [
    ./modules/home-manager/programs/git.nix
    ./modules/home-manager/programs/bash.nix
    ./modules/home-manager/programs/neovim.nix
    ./modules/home-manager/packages.nix
  ];

  home = {
    username = "ekku";
    stateVersion = "25.11";
  };
}
