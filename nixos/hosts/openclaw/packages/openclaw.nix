{ pkgs, inputs, ... }:

{
  environment.systemPackages = [
     inputs.nix-openclaw.packages.${pkgs.stdenv.hostPlatfrom.system}.openclaw-gateway 
     inputs.nix-openclaw-packages.${pkgs.stdenv.hostPlatfrom.system}.openclaw-tools
  ];
}
