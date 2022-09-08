-- https://github.com/hrsh7th/nvim-cmp

local cmp = require('cmp')
local luasnip = require('luasnip')

local source_menu_map = {
  emmet = 'Emmet',
  luasnip = 'Snip',
  nvim_lsp = 'LSP',
  buffer = 'Buff',
  path = 'Path',
  nvim_lsp_signature_help = 'Sig',
}

vim.opt.completeopt = 'menu,menuone,noselect'

cmp.setup({
  preselect = cmp.PreselectMode.Item,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- Order dictates priority
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'emmet' },
    { name = 'path' },
    { name = 'nvim_lsp_signature_help' },
  }, {
    {
      name = 'buffer',
      option = { get_bufnrs = vim.api.nvim_list_bufs },
    },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = function(entry, vim_item)
      local source = entry.source.name
      vim_item.menu = source_menu_map[source]
      vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
      return vim_item
    end,
  },
  mapping = {
    ['<C-B>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-F>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { 'c' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { 'c' }),
    ['<C-N>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
    ['<C-P>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(
      cmp.mapping.complete({
        config = {
          sources = {
            { name = 'nvim_lsp' },
          },
        },
      }),
      { 'i', 'c' }
    ),
    ['<C-E>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-Y>'] = cmp.mapping(
      cmp.mapping.confirm({
        select = true,
        behavior = cmp.ConfirmBehavior.Replace,
      }),
      { 'i', 'c' }
    ),
  },
})

local cmdline_view = {
  entries = {
    name = 'wildmenu',
    separator = '  ',
  },
}
cmp.setup.cmdline(':', {
  view = cmdline_view,
  sources = {
    { name = 'path' },
    { name = 'cmdline' },
  },
})

cmp.setup.cmdline('/', {
  view = cmdline_view,
  sources = {
    { name = 'buffer' },
  },
})
