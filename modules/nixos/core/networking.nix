{ ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  networking.firewall = {
    enable = true;

    allowedTCPPorts = [
      47984
      47989
      47990
      48010
      5201
    ];

    allowedUDPPorts = [ 
      5353
      47998
      47999
      48000
      48002
      48010 
      5201
    ];
  };
}
