{ config, pkgs, ... }:

{
  imports = [
    ./modules/home-manager/programs/git.nix
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
