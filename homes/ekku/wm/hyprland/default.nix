{ pkgs, ... }:

{
  xdg.enable = true;

  xdg.configFile."hypr" = {
    source = ./config;
    recursive = true;
  };

  home.packages = with pkgs; [
    adwaita-icon-theme
    gnome-themes-extra
  ];
}
