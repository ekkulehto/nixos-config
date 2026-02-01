{ ... }:

{
  extraLuaConfig = ''
    vim.opt.expandtab = true
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.smartindent = true
    vim.opt.autoindent = true
    vim.opt.clipboard = "unnamedplus"
    vim.opt.number = true
    vim.opt.relativenumber = true

    require("nvim-autopairs").setup({})
  '';
}
