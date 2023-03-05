local filter_table_by_keys = require('utils').filter_table_by_keys

local M = { 'mfussenegger/nvim-lint', lazy = true }

local linters = {
  gdlint = { 'pip3', 'git+https://github.com/Scony/godot-gdscript-toolkit.git' },
}
local supported_linters = vim.g.supported_linters and filter_table_by_keys(linters, vim.g.supported_linters) or linters
local linters_by_filetype = { gdscript = { 'gdlint' } }

function M.init()
  require('utils').augroup('lint', {
    {
      { 'BufWritePost', 'InsertLeave', 'TextChanged' },
      {
        pattern = '*.gd',
        callback = function()
          require('lint').try_lint()
        end,
      },
    },
  })

  require('installer').register('linter', supported_linters, vim.fn.stdpath('data') .. '/linters')
end

function M.config()
  local lint = require('lint')

  lint.linters.gdlint = {
    cmd = 'gdlint',
    stdin = false,
    stream = 'stderr',
    ignore_exitcode = true,
    parser = require('lint.parser').from_pattern(
      [[:(%d+): %w+: (.*)]],
      { 'lnum', 'message' },
      {},
      { col = 0, severity = vim.diagnostic.severity.WARN, source = 'gdlint' }
    ),
  }

  lint.linters_by_ft = linters_by_filetype
end

return M
