{ pkgs, ... }:

{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    wget
    waybar
    kitty
    git
    hyprpaper
    vulkan-tools
    mesa-demos
    wofi
  ];
}
