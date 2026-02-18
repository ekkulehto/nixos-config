{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      
      ../../nixos/common
      ../../nixos/users/ekku
    ];

  system.stateVersion = "25.11";
}

