return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        vim.keymap.set('n', '<leader>gb', gitsigns.blame, { desc = 'Gitsigns toggle line blame' })
      end
    })
  end,
}
