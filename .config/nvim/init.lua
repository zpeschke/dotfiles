-- Syntax highlighting
vim.cmd("syntax on")

-- Numbered column with custom fg color
vim.opt.number = true

-- Usually using dark terminal backgrounds
vim.opt.background = "dark"

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

-- Display statusline only if there are at least two windows
vim.opt.laststatus = 1

-- No background to match terminal background
vim.api.nvim_set_hl(0, "Normal", {
  ctermbg = "NONE",
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
  on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end,
}

-- Load lazy.nvim for plugin management
require("config.lazy")

-- Add telescope keybindings
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fw', function()
  telescope.live_grep({ default_text = vim.fn.expand('<cWORD>') })
end, { desc = 'Telescope live grep current word' })

require("oil").setup({
  keymaps = {
    ["h"] = { "actions.parent" },
    ["l"] = { "actions.select" },
  }
})
