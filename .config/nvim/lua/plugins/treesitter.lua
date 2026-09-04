return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = "*",
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'go', 'gomod', 'gowork', 'gosum',
          'python',
          'terraform', 'hcl',
          'jsonnet', 'json',
          'lua', 'yaml', 'groovy',
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    version = "*",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      max_lines = 4,
    },
  }
}
