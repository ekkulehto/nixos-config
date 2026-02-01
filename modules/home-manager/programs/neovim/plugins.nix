{ pkgs, ... }:

{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-autopairs   

    nvim-lspconfig
    nvim-cmp
    cmp-nvim-lsp
    cmp-path
  ];
}
