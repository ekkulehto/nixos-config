{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-autopairs   
  ];
}
