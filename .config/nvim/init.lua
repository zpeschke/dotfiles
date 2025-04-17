-- Syntax highlighting
vim.cmd("syntax on")

-- Numbered column with custom fg color
vim.opt.number = true

-- Set autoindenting
vim.opt.autoindent = true

-- 72 character columns
vim.opt.textwidth = 72

-- row and column and bottom right
vim.opt.ruler = true

-- highlight matching text in searches
vim.opt.hlsearch = true

-- always show 3 top/bottom lines when scrolling
vim.opt.scrolloff = 3

-- better backspace
vim.opt.backspace = 'indent,eol,start'

-- Set mapleader to backslack
vim.g.mapleader = "\\"

-- Set cursor to block in insert mode
vim.opt.guicursor = "i:block"

-- Always display statusline but only on bottom window
vim.opt.laststatus = 3

-- No background to match terminal background
vim.api.nvim_set_hl(0, "Normal", {
  bg = "NONE",
})

-- Set StatusLine background color to dark gray
vim.api.nvim_set_hl(0, "StatusLine", {
  bg = '#333333',
})

-- Map <leader>c to copy entire buffer or selection to system clipboard
vim.keymap.set('n', '<leader>c', ':%y+<CR>', { noremap = true, silent = true, desc = 'Copy entire buffer to clipboard' })
vim.keymap.set('v', '<leader>c', '"+y', { noremap = true, silent = true, desc = 'Copy selection to clipboard' })

-- Highlight trailing whitespace
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'red', ctermbg = 'red' })
vim.cmd([[match ExtraWhitespace /\s\+$/]])

-- Define :Rexplore command to open oil
vim.cmd([[
  command! Rexplore lua require("oil").open()
]])

-- Map :Rexplore to key
vim.api.nvim_set_keymap('n', '<leader>o', ':Rexplore<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '-', ':Rexplore<CR>', { noremap = true, silent = true })

-- LSP configuration for gopls
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

-- Load lazy.nvim for plugin management
require("config.lazy")

-- Load Telescope and keybindings
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fw', function()
  telescope.live_grep({ default_text = vim.fn.expand('<cWORD>') })
end, { desc = 'Telescope live grep current word' })

-- Load oil and modify keybindings
require("oil").setup({
  keymaps = {
    ["h"] = { "actions.parent" },
    ["l"] = { "actions.select" },
  },
  view_options = {
    show_hidden = true
  },
})

-- Load gitsigns and add keybindings
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")
    vim.keymap.set('n', '<leader>gb', gitsigns.blame, { desc = 'Gitsigns toggle line blame' })
  end
})
