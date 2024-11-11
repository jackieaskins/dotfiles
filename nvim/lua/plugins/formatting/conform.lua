---@class (exact) FormatterConfig
---@field required_file? string
---@field filetypes string[]

---@type table<string, FormatterConfig>
local formatters = {
  ['clang-format'] = { filetypes = { 'c' } },
  ['format-queries'] = { filetypes = { 'query' } },
  nixfmt = { filetypes = { 'nix' } },
  prettierd = {
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
    required_file = './stylua.toml',
    filetypes = { 'lua' },
  },
}

---@type LazySpec
return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  opts = function()
    local customized_formatters = {}
    for name, formatter in pairs(formatters) do
      if formatter.required_file then
        customized_formatters[name] = {
          require_cwd = true,
          cwd = require('conform.util').root_file(formatter.required_file),
        }
      end
    end

    local formatters_by_ft = {}
    for name, formatter in pairs(formatters) do
      for _, ft in ipairs(formatter.filetypes) do
        local curr_formatters = formatters_by_ft[ft] or {}
        table.insert(curr_formatters, name)
        formatters_by_ft[ft] = curr_formatters
      end
    end

    ---@module 'conform'
    ---@type conform.setupOpts
    return {
      default_format_opts = { lsp_format = 'fallback' },
      undojoin = true,
      formatters = customized_formatters,
      formatters_by_ft = formatters_by_ft,
      format_on_save = {},
    }
  end,
}
