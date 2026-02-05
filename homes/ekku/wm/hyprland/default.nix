{ pkgs, ... }:

{
  xdg.enable = true;

  xdg.configFile."hypr" = {
    source = ./config;
    recursive = true;
  };


  environment.systemPackages = with pkgs; [
    gnome.adwaita-icon-theme
    gnome-themes-extra
  ];
}
