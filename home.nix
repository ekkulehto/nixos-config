{ config, pkgs, ... }:

{
  imports = [
    ./modules/home-manager/programs/git.nix
    ./modules/home-manager/programs/bash.nix
    ./modules/home-manager/programs/neovim.nix
  ];


  home = {
    username = "ekku";
    stateVersion = "25.11";
  };




  home.packages = with pkgs; [
    wl-clipboard
    ripgrep
  ];
}
