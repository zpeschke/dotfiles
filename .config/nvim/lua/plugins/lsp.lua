return {
  "neovim/nvim-lspconfig",
  version = "*",
  config = function()
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")

    -- Enable Go LSP
    lspconfig.gopls.setup({})

    -- Enable Terraform LSP
    lspconfig.terraformls.setup({})

    -- Configure Jsonnet LSP if one doesn't already exist
    configs.jsonnet = {
      default_config = {
        cmd = {"jsonnet-language-server", "-t"},
        filetypes = {"jsonnet", "libsonnet"},
        root_dir = lspconfig.util.root_pattern(".git"),
        settings = {},
      }
    }

    -- Enable Jsonnet LSP
    lspconfig.jsonnet.setup({})
  end,
}
