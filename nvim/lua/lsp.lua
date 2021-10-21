local icons = require('lsp.icons')

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = true,
  float = {
    source = 'always',
    border = 'single',
  },
  severity_sort = true,
})

for level, icon in pairs(icons) do
  local sign = 'DiagnosticSign' .. level
  vim.fn.sign_define(sign, { text = icon, texthl = sign })
end

function _G.GetServers()
  return table.concat(require('lsp.servers'), '\n')
end

vim.api.nvim_exec(
  [[
  command! LspLog vsplit ~/.cache/nvim/lsp.log
  command! LspUpdateAll lua require('lsp.update').update_all_servers()
  command! -nargs=1 -complete=custom,v:lua.GetServers LspUpdate lua require('lsp.update').update_servers(<f-args>)
]],
  true
)
