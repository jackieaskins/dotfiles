local lspconfig = require'lspconfig'

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
  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  lsp_status.on_attach(client)
end

lspconfig.tsserver.setup{
  capabilities = lsp_status.capabilities,
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    custom_attach(client)
  end
}

lspconfig.sumneko_lua.setup{
  capabilities = lsp_status.capabilities,
  on_attach = custom_attach,
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { "vim" },
      }
    }
  }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      spacing = 0,
    }
  }
)
