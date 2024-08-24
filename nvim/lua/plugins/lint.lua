local filter_table_by_keys = require('utils').filter_table_by_keys

local linters = {
  gdlint = { 'pip', 'git+https://github.com/Scony/godot-gdscript-toolkit.git' },
  swiftlint = { 'brew', 'swiftlint' },
}
local supported_linters = vim.g.supported_linters and filter_table_by_keys(linters, vim.g.supported_linters) or linters
local linters_by_filetype = {
  gdscript = supported_linters.gdlint and { 'gdlint' } or nil,
  swift = supported_linters.swiftlint and { 'swiftlint' } or nil,
}

return {
  'mfussenegger/nvim-lint',
  lazy = true,
  init = function()
    require('utils').augroup('lint', {
      {
        { 'BufReadPost', 'BufWritePost', 'InsertLeave', 'TextChanged' },
        pattern = '*.gd,*.swift',
        callback = function()
          require('lint').try_lint()
        end,
      },
    })

    require('installer').register('linters', supported_linters, vim.fn.stdpath('data') .. '/linters')
  end,
  config = function()
    require('lint').linters_by_ft = linters_by_filetype
  end,
}
