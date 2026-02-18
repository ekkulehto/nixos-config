{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      ./graphics.nix
      
      ../../nixos/common
      ../../nixos/hosts/workstation
      ../../nixos/users/ekku
    ];

  system.stateVersion = "25.11";
}
