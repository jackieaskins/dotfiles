local utils = require('utils')

local M = {}

---@class FormatterConfig
---@field install_cmd? InstallCommand
---@field required_file? string
---@field filetypes string[]

---@type table<string, FormatterConfig>
local all_formatters = {
  ['clang-format'] = {
    install_cmd = { 'brew', 'clang-format' },
    filetypes = { 'c' },
  },
  deno_fmt = {
    filetypes = {
      'css',
      'html',
      'javascript',
      'javascriptreact',
      'json',
      'jsonc',
      'less',
      'markdown',
      'scss',
      'svelte',
      'typescript',
      'typescriptreact',
    },
    required_file = 'deno.json',
  },
  ['format-queries'] = { filetypes = { 'query' } },
  gdformat = {
    install_cmd = { 'pip', 'gdtoolkit' },
    required_file = 'project.godot',
    filetypes = { 'gdscript' },
  },
  gofmt = { filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' } },
  prettierd = {
    install_cmd = { 'npm', '@fsouza/prettierd' },
    required_file = './node_modules/.bin/prettier',
    filetypes = {
      'css',
      'graphql',
      'html',
      'javascript',
      'javascriptreact',
      'json',
      'jsonc',
      'less',
      'markdown',
      'scss',
      'svelte',
      'typescript',
      'typescriptreact',
    },
  },
  stylua = {
    install_cmd = { 'cargo', 'stylua' },
    required_file = './stylua.toml',
    filetypes = { 'lua' },
  },
  swiftformat = {
    install_cmd = { 'brew', 'swiftformat' },
    filetypes = { 'swift' },
  },
}

local supported_formatters = MY_CONFIG.supported_formatters
    and utils.filter_table_by_keys(all_formatters, MY_CONFIG.supported_formatters)
  or all_formatters

local formatters_by_ft = {}
for name, formatter in pairs(supported_formatters) do
  for _, ft in ipairs(formatter.filetypes) do
    local curr_formatters = formatters_by_ft[ft] or {}
    table.insert(curr_formatters, name)
    formatters_by_ft[ft] = curr_formatters
  end
end

---Get formatters for filetype
---@param filetype string
---@return string[]
function M.get_formatters(filetype)
  return formatters_by_ft[filetype] or {}
end

---Get formatters for filetype considering the required file
---@param filetype string
---@return string[]
function M.get_active_formatters(filetype)
  return vim.tbl_filter(function(formatter_name)
    local formatter = supported_formatters[formatter_name]
    return formatter.required_file == nil or utils.file_exists(formatter.required_file)
  end, M.get_formatters(filetype))
end

return M
