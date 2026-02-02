{ lib, pkgsUnstable, enableNoctalia ? false, ... }:

{
  home.packages = lib.optionals enableNoctalia [
    pkgsUnstable.noctalia-shell
  ];
}
