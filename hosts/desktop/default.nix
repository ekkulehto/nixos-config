{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/nixos/core
      ../../modules/nixos/programs/hyprland.nix
      ../../modules/nixos/programs/firefox.nix
    ];

  system.stateVersion = "25.11";
}
