local M = {}

-- Function to toggle checklist item completion
M.toggle_checklist_item = function()
  -- capture current line at cursor
  local current_line = vim.api.nvim_get_current_line()

  -- capture current cursor position
  local save_cursor = vim.api.nvim_win_get_cursor(0)

  -- variable that will have newline to replace current line with
  local new_line = ''

  -- Add checkbox if line doesn't have one
  if not (current_line:match('- %[ %]') or current_line:match('- %[x%]')) then
    new_line = current_line:gsub('- ', '- [ ] ')
  end

  -- replace '[ ]' with '[x]'
  if current_line:match('%[ %]') then
    new_line = current_line:gsub('%[ %]', '[x]')
  end

  -- replace '[x]' with '[ ]'
  if current_line:match('%[x%]') then
    new_line = current_line:gsub('%[x%]', '[ ]')
  end

  -- update the line
  if new_line ~= '' then
    vim.api.nvim_set_current_line(new_line)
  end

  -- restore cursor position
  vim.api.nvim_win_set_cursor(0, save_cursor)
end

return M
