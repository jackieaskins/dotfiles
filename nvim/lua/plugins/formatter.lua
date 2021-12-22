-- https://github.com/mhartington/formatter.nvim

local utils = require('utils')
local file_exists, is_executable = utils.file_exists, utils.is_executable

---@class Formatter
---@field name string
---@field install_cmd string[]
---@field exe string
---@field args fun():string[]
---@field required_filed string

---@type table<string, Formatter>
local formatters = {
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

local formatter_by_filetype = {
  javascript = formatters.prettier,
  javascriptreact = formatters.prettier,
  json = formatters.prettier,
  lua = formatters.stylua,
  markdown = formatters.prettier,
  typescript = formatters.prettier,
  typescriptreact = formatters.prettier,
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

local function update_formatters(formatter_names)
  local install_cmds = {}

  for _, name in ipairs(formatter_names) do
    install_cmds[name] = formatters[name].install_cmd
  end

  require('installer').install(install_cmds, vim.fn.stdpath('data') .. '/formatters')
end

local M = {}

M.formatters = formatters

function M.update_formatters(formatter_names)
  formatter_names = formatter_names and vim.split(formatter_names, ' ')
    or { formatter_by_filetype[vim.bo.filetype].name }

  update_formatters(formatter_names)
end

function M.update_all_formatters()
  update_formatters(vim.tbl_keys(formatters))
end

function M.format_on_save()
  local formatter = formatter_by_filetype[vim.bo.filetype]
  if formatter and is_executable(formatter.exe) and file_exists(formatter.required_file) then
    vim.cmd('FormatWrite')
  end
end

return M
