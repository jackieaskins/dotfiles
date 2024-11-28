---@type LazySpec
return {
  'saghen/blink.cmp',
  enabled = MY_CONFIG.completion_source == 'blink',
  build = MY_CONFIG.is_personal_machine and 'nix run .#build-plugin' or nil,
  version = not MY_CONFIG.is_personal_machine and 'v0.*' or nil,
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    accept = { auto_brackets = { enabled = true } },
    highlight = { use_nvim_cmp_as_default = true },
    keymap = {
      preset = 'default',
      ['<C-j>'] = { 'snippet_forward' },
      ['<C-k>'] = { 'snippet_backward', 'fallback' },
      ['<C-c>'] = { 'cancel' },
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
      autocomplete = {
        border = MY_CONFIG.border_style,
        selection = 'auto_insert',
      },
      documentation = { auto_show = true, border = MY_CONFIG.border_style },
      signature_help = { border = MY_CONFIG.border_style },
    },
  },
}
