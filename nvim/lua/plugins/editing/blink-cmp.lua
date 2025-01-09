---@type LazySpec
return {
  'saghen/blink.cmp',
  enabled = MY_CONFIG.completion_source == 'blink',
  build = {
    'rustup toolchain install nightly --force',
    'cargo build --release',
  },
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
      list = {
        selection = { preselect = true, auto_insert = true },
      },
      menu = {
        border = MY_CONFIG.border_style,
        draw = { treesitter = { 'lsp' } },
      },
    },
    keymap = {
      preset = 'default',
      cmdline = { preset = 'super-tab' },
      ['<C-j>'] = { 'snippet_forward' },
      ['<C-k>'] = { 'snippet_backward', 'fallback' },
      ['<C-c>'] = { 'cancel' },
      ['<C-space>'] = {
        function(cmp)
          cmp.show({ providers = { 'lsp' } })
        end,
      },
    },
    signature = {
      enabled = true,
      window = { border = MY_CONFIG.border_style },
    },
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        buffer = {
          opts = { get_bufnrs = vim.api.nvim_list_bufs },
        },
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
        lsp = { fallbacks = { 'buffer' } },
      },
    },
  },
}
