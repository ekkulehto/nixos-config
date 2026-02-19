{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      
      ../../nixos/common
      ../../nixos/hosts/openclaw
      ../../nixos/users/ekku
      ../../nixos/users/openclaw
    ];

  system.stateVersion = "25.11";
}

