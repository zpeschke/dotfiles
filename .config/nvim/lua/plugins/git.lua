return {
  {
    'lewis6991/gitsigns.nvim',
    version = '*',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        vim.keymap.set('n', '<leader>gb', gitsigns.blame, { desc = 'Gitsigns toggle line blame' })
      end
    },
  },
  {
    'NeogitOrg/neogit',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
        'nvim-telescope/telescope.nvim',
      },
      config = function()
        local neogit = require('neogit')
        vim.keymap.set('n', '<leader>gg', neogit.open, { desc = 'Open Neogit' })
      end,
  }
}
