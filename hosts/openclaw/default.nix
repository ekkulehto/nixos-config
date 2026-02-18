{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      
      ../../nixos/common
      ../../nixos/users/ekku

      ../../home/common
      ../../home/openclaw
      ../../home/users/ekku
    ];

  system.stateVersion = "25.11";
}

