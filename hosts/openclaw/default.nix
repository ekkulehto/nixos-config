{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      
      ../../nixos/common
      ../../nixos/users/ekku

      ../../home/users/ekku/openclaw
    ];

  system.stateVersion = "25.11";
}

