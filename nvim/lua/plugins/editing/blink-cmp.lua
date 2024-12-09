---@type LazySpec
return {
  'saghen/blink.cmp',
  enabled = MY_CONFIG.completion_source == 'blink',
  build = MY_CONFIG.is_personal_machine and 'nix run .#build-plugin' or nil,
  version = not MY_CONFIG.is_personal_machine and 'v0.*' or nil,
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      kind_icons = require('icons').get_lspkind_icons(),
      use_nvim_cmp_as_default = true,
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = {
        auto_show = true,
        window = { border = MY_CONFIG.border_style },
      },
      list = { selection = 'auto_insert' },
      menu = { border = MY_CONFIG.border_style },
    },
    keymap = {
      preset = 'default',
      ['<C-j>'] = { 'snippet_forward' },
      ['<C-k>'] = { 'snippet_backward', 'fallback' },
      ['<C-c>'] = { 'cancel' },
    },
    signature = {
      enabled = true,
      window = { border = MY_CONFIG.border_style },
    },
    sources = {
      completion = {
        enabled_providers = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      },
      providers = {
        buffer = {
          opts = { get_bufnrs = vim.api.nvim_list_bufs },
        },
        lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink' },
        lsp = {
          name = 'LSP',
          fallback_for = { 'lazydev' },
          module = 'blink.cmp.sources.lsp',
        },
      },
    },
  },
}
