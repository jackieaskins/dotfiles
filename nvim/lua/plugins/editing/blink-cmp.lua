---@type LazySpec
return {
  'saghen/blink.cmp',
  build = 'nix run .#build-plugin',
  enabled = MY_CONFIG.completion_source == 'blink',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
      ['<C-j>'] = { 'snippet_forward', 'fallback' },
      ['<C-k>'] = { 'snippet_backward', 'fallback' },
    },
    nerd_font_variant = 'normal',
    sources = {
      completion = {
        enabled_providers = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      },
      providers = {
        lsp = {
          name = 'LSP',
          fallback_for = { 'lazydev' },
          module = 'blink.cmp.sources.lsp',
        },
        lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink' },
      },
    },
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
