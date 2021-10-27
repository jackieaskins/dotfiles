require('lsp_signature').setup({
  bind = true, -- Required for border
  floating_window = false,
  handler_opts = { border = 'rounded' },
  hint_enable = true,
})
