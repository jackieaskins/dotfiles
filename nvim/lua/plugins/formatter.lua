-- https://github.com/mhartington/formatter.nvim

local utils = require('utils')
local file_exists, is_executable = utils.file_exists, utils.is_executable

local M = {}

---@class Formatter
---@field name string
---@field install_cmd string[]
---@field exe string
---@field args fun():string[]
---@field required_file string

---@type table<string, Formatter>
M.formatters = {
  prettier = {
    name = 'prettier',
    exe = 'prettierd',
    args = function()
      return { vim.api.nvim_buf_get_name(0) }
    end,
    required_file = './node_modules/.bin/prettier',
    install_cmd = { 'npm', '@fsouza/prettierd' },
  },
  stylua = {
    name = 'stylua',
    exe = 'stylua',
    args = function()
      return { '-' }
    end,
    required_file = './stylua.toml',
    install_cmd = { 'cargo', 'stylua' },
  },
}

M.formatter_by_filetype = {
  css = M.formatters.prettier,
  html = M.formatters.prettier,
  javascript = M.formatters.prettier,
  javascriptreact = M.formatters.prettier,
  json = M.formatters.prettier,
  jsonc = M.formatters.prettier,
  lua = M.formatters.stylua,
  markdown = M.formatters.prettier,
  typescript = M.formatters.prettier,
  typescriptreact = M.formatters.prettier,
}

local filetype_config = {}
for filetype, formatter in pairs(M.formatter_by_filetype) do
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

---Function to install/update provided list of formatter names
---@param formatter_names string[]
function M.update_formatters(formatter_names)
  local install_cmds = {}

  for _, name in ipairs(formatter_names) do
    install_cmds[name] = M.formatters[name].install_cmd
  end

  require('installer').install(install_cmds, vim.fn.stdpath('data') .. '/formatters')
end

function M.format_on_save()
  local formatter = M.formatter_by_filetype[vim.bo.filetype]

  if
    formatter
    and is_executable(formatter.exe)
    and require('lspconfig').util.root_pattern(formatter.required_file)(vim.fn.expand('%:p'))
  then
    vim.cmd('FormatWrite')
  end
end

return M
