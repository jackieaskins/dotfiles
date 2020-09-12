local nvim_lsp = require'nvim_lsp'
local completion = require'completion'
local diagnostic = require'diagnostic'

local lsp_status = require'lsp-status'
lsp_status.register_progress()

lsp_status.config({
  status_symbol = '',
  indicator_errors = '',
  indicator_warnings = '',
  indicator_info = '🛈',
  indicator_hint = '!',
  indicator_ok = '',
  spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
})

local custom_attach = function(client)
 completion.on_attach(client)
 diagnostic.on_attach(client)
 lsp_status.on_attach(client)
end

nvim_lsp.tsserver.setup{
  capabilities = lsp_status.capabilities,
  on_attach=custom_attach
}
