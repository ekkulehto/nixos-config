{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./boot.nix
      ./packages.nix
      ./module/nixos/users/ekku.nix
    ];

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



  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";

  environment.variables = {
    "EDITOR" = "nvim";
    "VISUAL" = "nvim";
    "SUDO_EDITOR" = "nvim";
  };
}
