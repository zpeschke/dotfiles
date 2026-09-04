return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local parsers = {
        'go', 'gomod', 'gowork', 'gosum',
        'python',
        'terraform', 'hcl',
        'jsonnet', 'json',
        'lua', 'yaml', 'groovy',
      }
      require('nvim-treesitter').install(parsers)

      -- terraform-vars (.tfvars) already maps to the terraform grammar via
      -- nvim-treesitter's own plugin/filetypes.lua
      local filetypes = vim.list_extend(vim.deepcopy(parsers), { 'terraform-vars' })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
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
  },
}
