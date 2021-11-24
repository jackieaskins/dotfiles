local utils = require('utils')
local file_exists, is_executable = utils.file_exists, utils.is_executable

local prettier = {
  exe = 'prettierd',
  args = function()
    return { vim.api.nvim_buf_get_name(0) }
  end,
  required_file = './node_modules/.bin/prettier',
}
local stylua = {
  exe = 'stylua',
  args = function()
    return { '-' }
  end,
  required_file = './stylua.toml',
}

local formatter_by_filetype = {
  javascript = prettier,
  javascriptreact = prettier,
  json = prettier,
  lua = stylua,
  markdown = prettier,
  typescript = prettier,
  typescriptreact = prettier,
}

local filetype_config = {}
for filetype, formatter in pairs(formatter_by_filetype) do
  filetype_config[filetype] = {
    function()
      return {
        exe = formatter.exe,
        args = formatter.args(),
        stdin = true,
      }
    end,
  }
end

require('formatter').setup({ filetype = filetype_config })

return {
  format_on_save = function()
    local formatter = formatter_by_filetype[vim.bo.filetype]
    if formatter and is_executable(formatter.exe) and file_exists(formatter.required_file) then
      vim.cmd('FormatWrite')
    end
  end,
}
