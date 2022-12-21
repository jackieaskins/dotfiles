local M = { 'sbdchd/neoformat', cmd = 'Neoformat' }

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
    install_cmd = { 'pip3', 'git+https://github.com/Scony/godot-gdscript-toolkit.git' },
    required_file = 'project.godot',
  },
}

local formatter_by_filetype = {
  css = formatters.prettierd,
  gdscript = formatters.gdformat,
  html = formatters.prettierd,
  javascript = formatters.prettierd,
  javascriptreact = formatters.prettierd,
  json = formatters.prettierd,
  jsonc = formatters.prettierd,
  lua = formatters.stylua,
  markdown = formatters.prettierd,
  svelte = formatters.prettierd,
  typescript = formatters.prettierd,
  typescriptreact = formatters.prettierd,
}

local function update_formatters(formatter_names)
  local install_cmds = {}

  for _, name in ipairs(formatter_names) do
    install_cmds[name] = formatters[name].install_cmd
  end

  require('installer').install(install_cmds, vim.fn.stdpath('data') .. '/formatters')
end

function M.init()
  local utils = require('utils')

  utils.user_command('FormatterUpdateAll', function()
    update_formatters(vim.tbl_keys(formatters))
  end)

  utils.user_command('FormatterUpdate', function(arg)
    local ft_formatter = { formatter_by_filetype[vim.bo.filetype].name }
    local formatter_names = arg.args ~= '' and vim.split(arg.args, ' ') or ft_formatter

    update_formatters(formatter_names)
  end, {
    nargs = '*',
    complete = function()
      return vim.tbl_keys(formatters)
    end,
  })

  utils.augroup('format_on_save', {
    {
      'BufWritePre',
      {
        callback = function()
          local formatter = formatter_by_filetype[vim.bo.filetype]

          if formatter and require('lspconfig').util.root_pattern(formatter.required_file)(vim.fn.expand('%:p')) then
            vim.cmd.Neoformat(formatter.name)
          end
        end,
      },
    },
  })
end

return M
