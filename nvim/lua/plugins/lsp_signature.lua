require('lsp_signature').setup({
  bind = true, -- Required for border
  floating_window = false,
  handler_opts = { border = 'single' },
  hint_enable = true,
})
