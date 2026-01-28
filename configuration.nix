{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./boot.nix
      ./packages.nix
      ./modules/nixos/users/ekku.nix
      ./modules/nixos/environment-variables.nix
      ./modules/nixos/hyprland.nix
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




  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";

}
