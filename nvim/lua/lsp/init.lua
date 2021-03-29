vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      spacing = 0
    },
    underline = true,
    signs = true,
  }
)
vim.cmd[[ highlight LspDiagnosticsDefaultHint guifg=#70ace5 ]]
vim.fn.sign_define("LspDiagnosticsSignError", {text = "", texthl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", texthl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "🛈", texthl = "LspDiagnosticsSignInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "!", texthl = "LspDiagnosticsSignHint"})

require'fzf_lsp'.setup()
require'lsp-status'.register_progress()
require'lsp/configs'.add_configs()
require'lsp/servers'.setup_servers()
