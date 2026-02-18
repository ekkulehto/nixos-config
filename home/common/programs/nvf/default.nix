{ pkgs, nvf, ... }:

{
  imports = [
    nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;

    enableManpages = true;

    settings = {
      vim = {
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        options = {
          expandtab = true;
          tabstop = 2;
          shiftwidth = 2;
          smartindent = true;
          autoindent = true;

          clipboard = "unnamedplus";

          number = true;
          relativenumber = true;
        };

        lsp = {
          enable = true;
        };

        languages.nix = {
          lsp.enable = true;
          lsp.servers = [ "nil" ];
        };

        autopairs.nvim-autopairs = {
          enable = true;
          setupOpts = { };
        };

        autocomplete.nvim-cmp = {
          enable = true;

          sourcePlugins = with pkgs.vimPlugins; [
            cmp-nvim-lsp
            cmp-path
            cmp-buffer
          ];

          sources = {
            nvim_lsp = "[LSP]";
            path = "[Path]";
            buffer = "[Buffer]";
          };

          mappings = {
            next = "<Tab>";
            previous = "<S-Tab>";
            confirm = "<CR>";
          };
        };
      };
    };
  };
}

