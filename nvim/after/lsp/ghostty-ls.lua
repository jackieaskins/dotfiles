---@type vim.lsp.Config
return {
  cmd = { vim.fn.stdpath('data') .. '/lsp-servers/ghostty-ls/bin/ghostty-ls' },
  filetypes = { 'ghostty' },
}
