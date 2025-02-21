---@type LazySpec
return {
  'saghen/blink.cmp',
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
    cmdline = {
      keymap = {
        preset = 'default',
        ['<Tab>'] = { 'select_and_accept' },
        ['<Up>'] = {},
        ['<Down>'] = {},
      },
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = {
        auto_show = true,
        window = { border = MY_CONFIG.border_style },
      },
      menu = {
        border = MY_CONFIG.border_style,
        draw = { treesitter = { 'lsp' } },
      },
    },
    fuzzy = {
      sorts = { 'exact', 'score', 'sort_text' },
    },
    keymap = {
      preset = 'default',
      ['<Tab>'] = {},
      ['<S-Tab>'] = {},
      ['<C-j>'] = { 'snippet_forward' },
      ['<C-k>'] = { 'snippet_backward', 'fallback' },
      ['<C-s>'] = { 'show_signature', 'hide_signature' },
      ['<C-c>'] = { 'cancel' },
      ['<C-space>'] = {
        function(cmp)
          cmp.show({ providers = { 'lsp' } })
        end,
      },
      ['<Up>'] = {},
      ['<Down>'] = {},
    },
    signature = {
      enabled = true,
      window = {
        border = MY_CONFIG.border_style,
        show_documentation = false,
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        lua = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        sql = { 'dadbod', 'snippets', 'buffer' },
      },
      providers = {
        buffer = {
          opts = { get_bufnrs = vim.api.nvim_list_bufs },
        },
        dadbod = {
          name = 'Dadbod',
          module = 'vim_dadbod_completion.blink',
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
