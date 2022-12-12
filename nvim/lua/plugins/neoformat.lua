local M = {}

---@class Formatter
---@field name string
---@field install_cmd string[]
---@field required_file string

---@type table<string, Formatter>
M.formatters = {
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

M.formatter_by_filetype = {
  css = M.formatters.prettierd,
  gdscript = M.formatters.gdformat,
  html = M.formatters.prettierd,
  javascript = M.formatters.prettierd,
  javascriptreact = M.formatters.prettierd,
  json = M.formatters.prettierd,
  jsonc = M.formatters.prettierd,
  lua = M.formatters.stylua,
  markdown = M.formatters.prettierd,
  svelte = M.formatters.prettierd,
  typescript = M.formatters.prettierd,
  typescriptreact = M.formatters.prettierd,
}

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

  if formatter and require('lspconfig').util.root_pattern(formatter.required_file)(vim.fn.expand('%:p')) then
    vim.cmd.Neoformat(formatter.name)
  end
end

return M
