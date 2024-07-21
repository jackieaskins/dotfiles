local utils = require('utils')

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
  swiftformat = {
    name = 'swiftformat',
    install_cmd = { 'brew', 'swiftformat' },
  },
  ['format-queries'] = {
    name = 'format-queries',
  },
  ['clang-format'] = {
    name = 'clang-format',
    install_cmd = { 'brew', 'clang-format' },
  },
}

local supported_formatters = vim.g.supported_formatters
    and utils.filter_table_by_keys(formatters, vim.g.supported_formatters)
  or formatters

local formatter_by_filetype = {
  c = supported_formatters['clang-format'],
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
  query = supported_formatters['format-queries'],
  scss = supported_formatters.prettierd,
  svelte = supported_formatters.prettierd,
  swift = supported_formatters.swiftformat,
  typescript = supported_formatters.prettierd,
  typescriptreact = supported_formatters.prettierd,
}

local function get_formatter_for_filetype(filetype)
  local formatter = formatter_by_filetype[filetype]
  local root_pattern = require('lspconfig').util.root_pattern

  if formatter and (not formatter.required_file or root_pattern(formatter.required_file)(vim.fn.expand('%:p'))) then
    return formatter
  end

  return nil
end

return {
  'stevearc/conform.nvim',
  lazy = true,
  opts = { undojoin = true },
  get_formatter_for_filetype = get_formatter_for_filetype,
  init = function()
    local install_cmds = {}
    for formatter, data in pairs(supported_formatters) do
      if data.install_cmd then
        install_cmds[formatter] = data.install_cmd
      end
    end

    require('installer').register('formatters', install_cmds, vim.fn.stdpath('data') .. '/formatters')

    utils.augroup('format_on_save', {
      {
        'BufWritePre',
        callback = function()
          local formatter = get_formatter_for_filetype(vim.bo.filetype)
          if formatter then
            require('conform').format({ formatters = { formatter.name } })
          end
        end,
      },
    })

    utils.user_command('Format', function()
      local formatter = formatter_by_filetype[vim.bo.filetype]

      if formatter then
        require('conform').format({ formatters = { formatter.name } })
        vim.cmd.write()
      else
        vim.notify('No formatter defined for filetype', vim.log.levels.ERROR)
      end
    end)
  end,
}
