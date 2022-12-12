local lint = require('lint')

local M = {}

M.linters = {
  gdlint = { 'pip3', 'git+https://github.com/Scony/godot-gdscript-toolkit.git' },
}

M.linters_by_filetype = {
  gdscript = { 'gdlint' },
}

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

lint.linters_by_ft = M.linters_by_filetype

---Function to install/update provided list of linter names
---@param linter_names string[]
function M.update_linters(linter_names)
  local install_cmds = {}

  for _, name in ipairs(linter_names) do
    install_cmds[name] = M.linters[name]
  end

  require('installer').install(install_cmds, vim.fn.stdpath('data') .. '/linters')
end

return M
