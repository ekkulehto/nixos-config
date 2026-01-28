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
      ./modules/nixos/locale.nix
      ./modules/nixos/hardware.nix
      ./modules/nixos/networking.nix
      ./modules/nixos/login.nix
      ./modules/nixos/nix-settings.nix
    ];

  system.stateVersion = "25.11";
}
