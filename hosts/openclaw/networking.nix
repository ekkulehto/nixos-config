{ ... }:

{
  networking = {
    hostName = "openclaw";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        22
      ];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
