return {
  "neovim/nvim-lspconfig",
  version = "*",
  config = function()
    vim.lsp.enable("gopls")
    vim.lsp.enable("pylsp")
    vim.lsp.enable("terraformls")

    vim.lsp.config("jsonnet", {
      cmd = {"jsonnet-language-server", "-t"},
      filetypes = {"jsonnet"},
      root_dir = function(bufnr, on_dir)
        on_dir(vim.fs.root(bufnr, ".git"))
      end,
      settings = {},
    })
    vim.lsp.enable("jsonnet")
  end,
}
