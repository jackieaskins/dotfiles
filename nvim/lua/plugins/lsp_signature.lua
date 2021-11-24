-- https://github.com/ray-x/lsp_signature.nvim

require('lsp_signature').setup({
  bind = true, -- Required for border
  floating_window = false,
  handler_opts = { border = 'rounded' },
  hint_enable = true,
})
