---@type LazySpec
return {
  'saghen/blink.cmp',
  build = 'nix run .#build-plugin',
  enabled = MY_CONFIG.completion_source == 'blink',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<C-y>'] = { 'select_and_accept' },

      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

      ['<C-j>'] = { 'snippet_forward', 'fallback' },
      ['<C-k>'] = { 'snippet_backward', 'fallback' },
    },
    nerd_font_variant = 'normal',
    trigger = {
      signature_help = { enabled = true },
    },
    windows = {
      autocomplete = {
        border = MY_CONFIG.border_style,
        draw = 'reversed',
        selection = 'auto_insert',
      },
      documentation = { border = MY_CONFIG.border_style },
      signature_help = { border = MY_CONFIG.border_style },
    },
  },
}
