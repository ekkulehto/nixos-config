{ ... }:

{
  imports = [
    ./plugins.nix
    ./packages.nix
    ./config.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
