local M = {}

M.get_buffer_cwd = function()
  local path = vim.fn.expand('%:p:h')

  -- oil.nvim prepends buffer path URLs with 'oil://', which causes
  -- telescoped being invoked from oil.nvim using the 'cwd' arg not to work.
  if path:match('^oil://') then
    path = path:gsub('^oil://', '')
  end

  return path
end

return M
