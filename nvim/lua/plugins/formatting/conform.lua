local utils = require('utils')

---@class FormatterConfig
---@field install_cmd? InstallCommand
---@field required_file? string
---@field filetypes string[]

---@type table<string, FormatterConfig>
local formatters = {
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
    install_cmd = { 'pip', 'git+https://github.com/Scony/godot-gdscript-toolkit.git' },
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
    and utils.filter_table_by_keys(formatters, MY_CONFIG.supported_formatters)
  or formatters

---@type LazySpec
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

    ---@module 'conform'
    ---@type conform.setupOpts
    return {
      undojoin = true,
      formatters = customized_formatters,
      formatters_by_ft = formatters_by_ft,
      format_on_save = {},
      default_format_opts = { quiet = true },
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
