local file_exists = require'my_utils'.file_exists
local api = vim.api

local formatters = {
  prettier = {
    test_path = './node_modules/.bin/prettier',
    exe = './node_modules/.bin/prettier',
    args = function() return {'--stdin-filepath', api.nvim_buf_get_name(0)} end,
    filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'},
    match = '*.js,*.jsx,*.ts,*.tsx',
  },
  google_java_format = {
    test_path = './google-java-format.jar',
    exe = 'java',
    args = function() return {'-jar', './google-java-format.jar', api.nvim_buf_get_name(0)} end,
    filetypes = {'java'},
    match = '*.java',
  },
  lua_format = {
    test_path = './.lua-format',
    exe = 'lua-format',
    filetypes = {'lua'},
    match = '*.lua',
  },
}

local function get_filetype()
  local filetype_map = {}

  for _, formatter in pairs(formatters) do
    for _, filetype in ipairs(formatter.filetypes) do
      filetype_map[filetype] = {
        function()
          return {
            exe = formatter.exe,
            args = formatter.args and formatter.args() or nil,
            stdin = true,
          }
        end,
      }
    end
  end

  return filetype_map
end

require'formatter'.setup({logging = true, filetype = get_filetype()})

local function get_autocmds()
  local autocmds = {}

  for name, formatter in pairs(formatters) do
    table.insert(autocmds, {
      'BufWritePost',
      formatter.match,
      'lua require"my_plugins/formatter".format_on_save("' .. name .. '")',
    })
  end

  return autocmds
end

require'my_utils'.augroup('auto_format', get_autocmds())

local M = {}

function M.format_on_save(name)
  local formatter = formatters[name]
  local format_file_exists = file_exists(formatter.test_path)
  local is_valid = format_file_exists and vim.fn.executable(formatter.exe) == 1

  if is_valid then
    vim.cmd 'FormatWrite'
  elseif format_file_exists then
    print('Format file exists for ' .. name .. ', but formatter is not executable')
  end
end

return M
