{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep
    fastfetch
    vim
    wget
  ];
}
