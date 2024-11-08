---@type LazySpec
return {
  'saghen/blink.cmp',
  build = 'nix run .#build-plugin',
  enabled = MY_CONFIG.completion_source == 'blink',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    highlight = { use_nvim_cmp_as_default = true },
    keymap = {
      preset = 'default',
      ['<C-j>'] = { 'snippet_forward', 'fallback' },
      ['<C-k>'] = { 'snippet_backward', 'fallback' },
    },
    kind_icons = require('icons').get_lspkind_icons(),
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
      autocomplete = { border = MY_CONFIG.border_style },
      documentation = { border = MY_CONFIG.border_style },
      signature_help = { border = MY_CONFIG.border_style },
    },
  },
}
