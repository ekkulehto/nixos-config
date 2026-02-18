{ noctalia, ... }:

{
  imports = [
    noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
 };
}
