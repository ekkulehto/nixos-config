{ pkgs, inputs, ... }:

{
  environment.systemPackages = [
     inputs.nix-openclaw.packages.${pkgs.stdenv.hostPlatform.system}.openclaw-gateway 
     inputs.nix-openclaw.packages.${pkgs.stdenv.hostPlatform.system}.openclaw-tools
  ];
}
