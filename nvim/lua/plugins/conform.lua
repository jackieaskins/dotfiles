local utils = require('utils')
local augroup, filter_table_by_keys = utils.augroup, utils.filter_table_by_keys

local formatters = {
  prettierd = {
    name = 'prettierd',
    install_cmd = { 'npm', '@fsouza/prettierd' },
    required_file = './node_modules/.bin/prettier',
  },
  stylua = {
    name = 'stylua',
    install_cmd = { 'cargo', 'stylua' },
    required_file = './stylua.toml',
  },
  gdformat = {
    name = 'gdformat',
    install_cmd = { 'pip', 'git+https://github.com/Scony/godot-gdscript-toolkit.git' },
    required_file = 'project.godot',
  },
}

local supported_formatters = vim.g.supported_formatters and filter_table_by_keys(formatters, vim.g.supported_formatters)
  or formatters

local formatter_by_filetype = {
  css = supported_formatters.prettierd,
  gdscript = supported_formatters.gdformat,
  graphql = supported_formatters.prettierd,
  html = supported_formatters.prettierd,
  javascript = supported_formatters.prettierd,
  javascriptreact = supported_formatters.prettierd,
  json = supported_formatters.prettierd,
  jsonc = supported_formatters.prettierd,
  less = supported_formatters.prettierd,
  lua = supported_formatters.stylua,
  markdown = supported_formatters.prettierd,
  scss = supported_formatters.prettierd,
  svelte = supported_formatters.prettierd,
  typescript = supported_formatters.prettierd,
  typescriptreact = supported_formatters.prettierd,
}

local function get_formatter_for_filetype(filetype)
  local formatter = formatter_by_filetype[filetype]
  local root_pattern = require('lspconfig').util.root_pattern

  if formatter and root_pattern(formatter.required_file)(vim.fn.expand('%:p')) then
    return formatter
  end

  return nil
end

return {
  'stevearc/conform.nvim',
  lazy = true,
  config = true,
  get_formatter_for_filetype = get_formatter_for_filetype,
  init = function()
    local install_cmds = {}

    for formatter, data in pairs(supported_formatters) do
      install_cmds[formatter] = data.install_cmd
    end
    require('installer').register('formatter', install_cmds, vim.fn.stdpath('data') .. '/formatters')

    augroup('format_on_save', {
      {
        'BufWritePre',
        callback = function(args)
          local formatter = get_formatter_for_filetype(vim.bo.filetype)
          if formatter then
            require('conform').format({ bufnr = args.buf, formatters = { formatter.name } })
          end
        end,
      },
    })
  end,
}
