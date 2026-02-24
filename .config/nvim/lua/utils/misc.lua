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

M.get_url = function()
  remote_obj = vim.system({'git', 'remote', 'get-url', 'origin'}, { text = true }):wait()
  if remote_obj.code ~= 0 then
    print('error: path does not appear to be within a git repository')
    return
  end

  root_obj = vim.system({'git', 'rev-parse', '--show-toplevel'}, { text = true }):wait()
  branch_obj = vim.system({'git', 'branch', '--show-current'}, { text = true }):wait()

  -- newlines need to be removed from all vim.system stdout
  -- hyphens in the git root path need to be escaped with %
  remote_url = remote_obj.stdout:gsub('%s+$', ''):gsub(':', '/'):gsub('.git$', ''):gsub('^git@', 'https://')
  root = root_obj.stdout:gsub('%s+$', ''):gsub('%-', '%%%-')
  branch = branch_obj.stdout:gsub('%s+$', '')
  path = vim.fn.expand('%:p'):gsub(root .. '/', '')

  git_url = remote_url .. '/tree/' .. branch .. '/' .. path
  vim.fn.setreg('+', git_url)
  vim.notify("Copied url to clipboard: " .. git_url)
end

return M
