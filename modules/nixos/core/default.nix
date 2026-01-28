{ ... }:

{
  imports = [
    ./boot.nix
    ./environment-variables.nix
    ./hardware.nix
    ./locale.nix
    ./login.nix
    ./networking.nix
    ./nix-settings.nix
    ./packages.nix
  ];
}
