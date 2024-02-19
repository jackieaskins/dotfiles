local filter_table_by_keys = require('utils').filter_table_by_keys

local linters = {
  gdlint = { 'pip3', 'git+https://github.com/Scony/godot-gdscript-toolkit.git' },
}
local supported_linters = vim.g.supported_linters and filter_table_by_keys(linters, vim.g.supported_linters) or linters
local linters_by_filetype = {
  gdscript = supported_linters.gdlint and nil or { 'gdlint' },
}

local function get_linters_for_filetype(filetype)
  return linters_by_filetype[filetype] or {}
end

return {
  'mfussenegger/nvim-lint',
  lazy = true,
  get_linters_for_filetype = get_linters_for_filetype,
  init = function()
    require('utils').augroup('lint', {
      {
        { 'BufWritePost', 'InsertLeave', 'TextChanged' },
        pattern = '*.gd',
        callback = function()
          require('lint').try_lint()
        end,
      },
    })

    require('installer').register('linter', supported_linters, vim.fn.stdpath('data') .. '/linters')
  end,
  config = function()
    require('lint').linters_by_ft = linters_by_filetype
  end,
}
