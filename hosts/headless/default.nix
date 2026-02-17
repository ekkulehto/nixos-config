{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/nixos/core

      ../../modules/nixos/packages
    ];

  system.stateVersion = "25.11";
}
