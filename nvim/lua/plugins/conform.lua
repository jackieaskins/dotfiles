local utils = require('utils')

---@class (exact) FormatterConfig
---@field install_cmd? InstallCommand
---@field required_file? string
---@field filetypes string[]

---@type table<string, FormatterConfig>
local formatters = {
  ['clang-format'] = {
    install_cmd = { 'brew', 'clang-format' },
    filetypes = { 'c' },
  },
  ['format-queries'] = { filetypes = { 'query' } },
  gdformat = {
    install_cmd = { 'pip', 'git+https://github.com/Scony/godot-gdscript-toolkit.git' },
    required_file = 'project.godot',
    filetypes = { 'gdscript' },
  },
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

local supported_formatters = vim.g.supported_formatters
    and utils.filter_table_by_keys(formatters, vim.g.supported_formatters)
  or formatters

return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  opts = function()
    local customized_formatters = {}
    for name, formatter in pairs(supported_formatters) do
      if formatter.required_file then
        customized_formatters[name] = {
          require_cwd = true,
          cwd = require('conform.util').root_file(formatter.required_file),
        }
      end
    end

    local formatters_by_ft = {}
    for name, formatter in pairs(supported_formatters) do
      for _, ft in ipairs(formatter.filetypes) do
        local curr_formatters = formatters_by_ft[ft] or {}
        table.insert(curr_formatters, name)
        formatters_by_ft[ft] = curr_formatters
      end
    end

    return {
      default_format_opts = { lsp_format = 'fallback' },
      undojoin = true,
      formatters = customized_formatters,
      formatters_by_ft = formatters_by_ft,
      format_on_save = {},
    }
  end,
  init = function()
    local install_cmds = {}
    for formatter, data in pairs(supported_formatters) do
      if data.install_cmd then
        install_cmds[formatter] = data.install_cmd
      end
    end

    require('installer').register('formatters', install_cmds, vim.fn.stdpath('data') .. '/formatters')
  end,
}
