{ ... }:

{
  imports = [
    ./options.nix
    ./config.nix
    ./secrets.nix
    ./service.nix
  ];

  services.openclaw.enable = true;
}
