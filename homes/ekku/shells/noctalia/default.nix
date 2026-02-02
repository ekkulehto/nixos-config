{ lib, noctalia, pkgsUnstable, enableNoctalia ? false, ... }:

{
  imports = lib.optionals enableNoctalia [
    noctalia.homeModules.default
  ];

  programs.noctalia-shell = lib.mkIf enableNoctalia {
    enable = true;

    package = pkgsUnstable.noctalia-shell;

    # settings = { ... };
  };
}

