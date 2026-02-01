{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-autopairs   

    nvim-lspconfig
    cmp-nvim-lsp
    cmp-path
  ];
}
