{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/nixos/core

      ../../modules/nixos/networking/openclaw

      ../../modules/nixos/packages

      ../../modules/nixos/users/openclaw
    ];

  system.stateVersion = "25.11";
}
