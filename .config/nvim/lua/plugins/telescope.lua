return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  version = "*",
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope.builtin')

    local get_cwd = function()
      local path = vim.fn.expand('%:p:h')

      -- oil.nvim prepends buffer path URLs with 'oil://', which causes
      -- telescoped being invoked from oil.nvim using the 'cwd' arg not to work.
      if path:match('^oil://') then
        path = path:gsub('^oil://', '')
      end

      return path
    end

    -- global file search from where buffer was originally opened
    vim.keymap.set('n', '<leader>tf', telescope.find_files, { desc = 'Telescope find files' })

    -- relative file search
    vim.keymap.set('n', '<leader>tF', function()
      telescope.find_files({ cwd = get_cwd() })
    end, { desc = 'Telescope find files' })

    -- global grep from where buffer was originally opened
    vim.keymap.set('n', '<leader>tg', telescope.live_grep, { desc = 'Telescope live grep' })

    -- relative grep
    vim.keymap.set('n', '<leader>tG', function()
      telescope.live_grep({ cwd = get_cwd() })
    end, { desc = 'Telescope live grep' })

    vim.keymap.set('n', '<leader>tb', telescope.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>th', telescope.help_tags, { desc = 'Telescope help tags' })

    vim.keymap.set('n', '<leader>tw', function()
      telescope.live_grep({ default_text = vim.fn.expand('<cWORD>') })
    end, { desc = 'Telescope live grep current word' })
  end,
}
