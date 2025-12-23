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

M.open_jira = function()
  local open_command = 'xdg-open'
  local jira_url = vim.env.JIRA_URL

  if jira_url == nil then
    print('JIRA_URL must be defined')
    return
  end

  local url = jira_url .. '/browse/' .. vim.fn.expand('<cWORD>')
  vim.system({ open_command, url }, { detach = true })
end

return M
