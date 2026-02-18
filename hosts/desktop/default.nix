{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      ./graphics.nix
      
      ../../nixos/common
      ../../nixos/desktop
      ../../nixos/users/ekku

      ../../home/common
      ../../home/desktop
      ../../home/users/ekku
    ];

  system.stateVersion = "25.11";
}
