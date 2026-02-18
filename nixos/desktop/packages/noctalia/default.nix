{ lib, noctalia, pkgs, ... }:

{
  environment.systemPackages = lib.mkDefault [
    noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
