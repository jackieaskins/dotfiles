local M = {}

function M.update()
  local language_server = 'eslint-ls'

  return {
    'rm -rf ' .. language_server,
    'git clone https://github.com/jackieaskins/' .. language_server,
    'cd ' .. language_server,
    'npm install',
    'npm run distribute',
  }
end

return M
