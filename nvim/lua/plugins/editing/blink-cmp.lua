local snippet_engine = require('utils').get_snippet_engine()

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
    },
    cmdline = {
      completion = {
        menu = { auto_show = true },
      },
      keymap = {
        ['<Tab>'] = { 'select_and_accept' },
      },
    },
    completion = {
      accept = {
        auto_brackets = { enabled = false },
      },
      documentation = { auto_show = true },
      keyword = { range = 'full' },
      menu = {
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'source_name' },
          },
          components = {
            source_name = {
              text = function(ctx)
                local client_name = ctx.item.client_name

                if client_name then
                  local display_name = require('lsp.utils').get_server_display_name(client_name)
                  return ctx.source_name .. '[' .. display_name .. ']'
                end

                return ctx.source_name
              end,
            },
          },
          treesitter = { 'lsp' },
        },
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
      window = { show_documentation = false },
    },
    snippets = {
      ---@diagnostic disable-next-line: assign-type-mismatch
      preset = snippet_engine == 'nvim' and 'default' or snippet_engine,
    },
    sources = {
      default = { 'lazydev', 'dadbod', 'lsp', 'path', 'snippets', 'buffer' },
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
      },
    },
  },
}
