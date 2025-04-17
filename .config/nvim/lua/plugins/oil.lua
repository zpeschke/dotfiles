return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  config = function()
    require("oil").setup({
      keymaps = {
        ["h"] = { "actions.parent" },
        ["l"] = { "actions.select" },
      },
      view_options = {
        show_hidden = true
      },
    })

    -- Define :Rexplore command to open oil
    vim.cmd([[
      command! Rexplore lua require("oil").open()
    ]])

    -- Map :Rexplore to key
    vim.api.nvim_set_keymap('n', '<leader>o', ':Rexplore<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '-', ':Rexplore<CR>', { noremap = true, silent = true })
  end,
}
