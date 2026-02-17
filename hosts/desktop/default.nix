{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/nixos/core

      ../../modules/nixos/networking/desktop

      ../../modules/nixos/packages

      ../../modules/nixos/programs

      ../../modules/nixos/desktops/hyprland

      ../../modules/nixos/graphics/amd

      ../../modules/nixos/users/ekku

      ../../profiles
    ];

  system.stateVersion = "25.11";
}
