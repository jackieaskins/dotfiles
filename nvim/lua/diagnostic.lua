local icons = require('diagnostic.icons')
local hls = {
  [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
  [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
  [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
  [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
}

vim.diagnostic.config({
  float = { source = true },
  signs = {
    text = icons,
    priority = require('sign_priorities').diagnostics,
  },
  severity_sort = true,
  status = {
    format = function(severity_counts)
      return vim
        .iter(pairs(severity_counts))
        :map(function(severity, count)
          return ('%%#%s#%s%s'):format(hls[severity], icons[severity], count)
        end)
        :join(' ')
    end,
  },
  update_in_insert = false,
  virtual_lines = false,
  virtual_text = false,
})
