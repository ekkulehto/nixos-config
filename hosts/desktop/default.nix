{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/nixos/core

      ../../modules/nixos/users/ekku.nix

      ../../modules/nixos/programs
    ];

  system.stateVersion = "25.11";
}
