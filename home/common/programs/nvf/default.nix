{ pkgs, nvf, ... }:

{
  imports = [
    nvf.homeManagerModules.default
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = true;
      vimAlias = true;

      options = {
        expandtab = true;
        tabstop = 2;
        shiftwidth = 2;
        smartindent = true;
        autoindent = true;
        clipboard = "unnamedplus";
      };

      lineNumberMode = "relNumber";

      lsp.enable = true;

      languages.nix.enable = true;

      autopairs.nvim-autopairs.enable = true;
      autocomplete.nvim-cmp.enable = true;
    };
  };
}

