return {
  "neovim/nvim-lspconfig",
  config = function()
    require("lspconfig").gopls.setup {
      cmd = {"gopls"},
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    }

    require("lspconfig").terraformls.setup({
      cmd = {"terraform-ls", "serve"}
    })
  end,
}
