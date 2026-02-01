{ ... }:

{
  programs.neovim.extraLuaConfig = ''
    vim.opt.expandtab = true
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.smartindent = true
    vim.opt.autoindent = true
    vim.opt.clipboard = "unnamedplus"
    vim.opt.number = true
    vim.opt.relativenumber = true

    require("nvim-autopairs").setup({})

    local cmp = require("cmp")

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "path" },
      },
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config("nil_ls", {
      capabilities = capabilities,
    })
    vim.lsp.enable("nil_ls")

    vim.lsp.config("qmlls", {
      capabilities = capabilities,
    })
    vim.lsp.enable("qmlls")
  '';
}
