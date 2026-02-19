{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.agenix.packages.${pkgs.system}.default
  ];

  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
}
