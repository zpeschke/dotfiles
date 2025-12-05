return {
  "neovim/nvim-lspconfig",
  version = "*",
  config = function()
    local lspconfig = require("lspconfig")

    vim.lsp.enable("gopls")
    vim.lsp.enable("pylsp")
    vim.lsp.enable("terraformls")

    vim.lsp.config("jsonnet", {
      cmd = {"jsonnet-language-server", "-t"},
      filetypes = {"jsonnet", "libsonnet"},
      root_dir = lspconfig.util.root_pattern(".git"),
      settings = {},
    })
    vim.lsp.enable("jsonnet")
  end,
}
