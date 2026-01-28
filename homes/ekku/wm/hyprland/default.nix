{ ... }:

{
  xdg.enable = true;

  xdg.configFile."hypr" = {
    source = ./config;
    recursive = true;
  };
}
