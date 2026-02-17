{ lib, noctalia, pkgs, enableNoctalia ? false, ... }:

{
  imports = lib.optionals enableNoctalia [
    noctalia.homeModules.default
  ];

  programs.noctalia-shell = lib.mkIf enableNoctalia {
    enable = true;

    package = noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

    # settings = { ... };
  };
}
