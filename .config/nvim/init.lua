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

-- Set LineNr foreground color to dark gray
vim.api.nvim_set_hl(0, "LineNr", {
  fg=238,
  ctermfg=238,
})

-- Map <leader>c to copy entire buffer or selection to system clipboard
vim.keymap.set('n', '<leader>c', ':%y+<CR>', { noremap = true, silent = true, desc = 'Copy entire buffer to clipboard' })
vim.keymap.set('v', '<leader>c', '"+y', { noremap = true, silent = true, desc = 'Copy selection to clipboard' })

-- Map <leader>f to tab split for active window full screen
vim.keymap.set('n', '<leader>f', ':tab split<CR>', { noremap = true, silent = true, desc = 'Full screen current window in tab' })

-- Highlight trailing whitespace
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'red', ctermbg = 'red' })
vim.cmd([[match ExtraWhitespace /\s\+$/]])

-- Load todo utils
local todo_utils = require("utils.todo")
vim.keymap.set('n', '<leader><Space>', todo_utils.toggle_checklist_item, { noremap = true })

-- Load lazy.nvim for plugin management
require("config.lazy")
