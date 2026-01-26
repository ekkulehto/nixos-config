{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.getty.autologinUser = "ekku";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Helsinki";
  
  console.keyMap = "fi";
  services.xserver.xkb = {
    layout = "fi";
  };

  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.users.ekku = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";

  environment.variables = {
    "EDITOR" = "nvim";
    "VISUAL" = "nvim";
    "SUDO_EDITOR" = "nvim";
  };
}
