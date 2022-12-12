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

lint.linters_by_ft = {
  gdscript = { 'gdlint' },
}
