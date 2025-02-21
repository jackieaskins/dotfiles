local utils = require('utils')

---@class LinterConfig
---@field install_cmd? InstallCommand
---@field filetypes string[]

---@type table<string, LinterConfig>
local linters = {
  gdlint = {
    filetypes = { 'gdscript' },
    install_cmd = { 'pip', 'git+https://github.com/Scony/godot-gdscript-toolkit.git' },
  },
  swiftlint = {
    filetypes = { 'swift' },
    install_cmd = { 'brew', 'swiftlint' },
  },
}
local supported_linters = MY_CONFIG.supported_linters
    and utils.filter_table_by_keys(linters, MY_CONFIG.supported_linters)
  or linters

local linters_by_filetype = {}
for name, linter in pairs(supported_linters) do
  for _, ft in ipairs(linter.filetypes) do
    local curr_linters = linters_by_filetype[ft] or {}
    table.insert(curr_linters, name)
    linters_by_filetype[ft] = curr_linters
  end
end

---@type LazySpec
return {
  'mfussenegger/nvim-lint',
  lazy = true,
  init = function()
    utils.augroup('lint_check', {
      {
        'FileType',
        pattern = table.concat(vim.tbl_keys(linters_by_filetype), ','),
        callback = function(args)
          utils.augroup('lint', {
            {
              { 'BufReadPost', 'BufWritePost', 'InsertLeave', 'TextChanged' },
              callback = function()
                require('lint').try_lint()
              end,
              buffer = args.buf,
            },
          })
        end,
      },
    })

    local install_cmds = {}
    for linter, data in pairs(supported_linters) do
      if data.install_cmd then
        install_cmds[linter] = data.install_cmd
      end
    end

    require('installer').register('linters', install_cmds, vim.fn.stdpath('data') .. '/linters')
  end,
  config = function()
    require('lint').linters_by_ft = linters_by_filetype
  end,
}
