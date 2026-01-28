{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/nixos/boot.nix
      ../../modules/nixos/packages.nix
      ../../modules/nixos/users/ekku.nix
      ../../modules/nixos/environment-variables.nix
      ../../modules/nixos/programs/hyprland.nix
      ../../modules/nixos/programs/firefox.nix
      ../../modules/nixos/locale.nix
      ../../modules/nixos/hardware.nix
      ../../modules/nixos/networking.nix
      ../../modules/nixos/login.nix
      ../../modules/nixos/nix-settings.nix
    ];

  system.stateVersion = "25.11";
}
