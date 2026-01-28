{ config, pkgs, ... }:

{
  imports = [
    ./modules/home-manager/programs/git.nix
  ];


  home = {
    username = "ekku";
    stateVersion = "25.11";
  };



  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    extraLuaConfig = ''
      vim.opt.expandtab = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.smartindent = true
      vim.opt.autoindent = true
      vim.opt.clipboard = "unnamedplus"
      vim.opt.number = true
      vim.opt.relativenumber = true
    '';
  };

  home.packages = with pkgs; [
    wl-clipboard
    ripgrep
  ];
}
