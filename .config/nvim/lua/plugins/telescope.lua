return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  version = "*",
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope.builtin')
    vim.keymap.set('n', '<leader>tf', telescope.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>tg', telescope.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>tb', telescope.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>th', telescope.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>tw', function()
      telescope.live_grep({ default_text = vim.fn.expand('<cWORD>') })
    end, { desc = 'Telescope live grep current word' })
  end,
}
