local M = { 'mfussenegger/nvim-lint', lazy = true }

local linters = {
  gdlint = { 'pip3', 'git+https://github.com/Scony/godot-gdscript-toolkit.git' },
}
local linters_by_filetype = {
  gdscript = { 'gdlint' },
}

function M.init()
  local utils = require('utils')

  utils.augroup('lint', {
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

  local function update_linters(linter_names)
    local install_cmds = {}

    for _, name in ipairs(linter_names) do
      install_cmds[name] = linters[name]
    end

    require('installer').install(install_cmds, vim.fn.stdpath('data') .. '/linters')
  end

  utils.user_command('LinterUpdateAll', function()
    update_linters(vim.tbl_keys(linters))
  end)

  utils.user_command('LinterUpdate', function(arg)
    local linter_names = arg.args ~= '' and vim.split(arg.args, ' ') or linters_by_filetype[vim.bo.filetype]
    update_linters(linter_names)
  end, {
    nargs = '*',
    complete = function()
      return vim.tbl_keys(linters)
    end,
  })
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
