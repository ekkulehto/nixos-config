{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/nixos/core

      ../../modules/nixos/packages

      ../../modules/nixos/programs

      ../../modules/nixos/users/ekku
    ];

  system.stateVersion = "25.11";
}
