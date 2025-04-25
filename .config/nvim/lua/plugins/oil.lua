return {
  'stevearc/oil.nvim',
  version = "*",
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  config = function()
    require("oil").setup({
      use_default_keymaps = false,
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = { "actions.select" },
        ["l"] = { "actions.select" },
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-v>"] = { "actions.select", opts = { horizontal = true } }, -- Moved from <C-h> to resolve conflict with tmux/vim navigation
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        -- ["<C-l>"] = "actions.refresh", -- Removed to resolve conflict with tmux/vim navigation
        ["-"] = { "actions.parent", mode = "n" },
        ["h"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, bufnr)
          if name == ".." then
            return true
          else
            return false
          end
        end,
      },
    })

    -- Define :Rexplore command to open oil
    vim.cmd([[
      command! Rexplore lua require("oil").open()
    ]])

    -- Map :Rexplore to key
    vim.api.nvim_set_keymap('n', '-', ':Rexplore<CR>', { noremap = true, silent = true })
  end,
}
