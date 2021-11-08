local fn = vim.fn
local cmp = require('cmp')
local luasnip = require('luasnip')
local t = require('utils').t

-- Order dictates priority
local source_menu_map = {
  luasnip = 'Snip',
  nvim_lsp = 'LSP',
  buffer = 'Buff',
  path = 'Path',
  calc = 'Calc',
}

vim.opt.completeopt = 'menu,menuone,noselect'

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'calc' },
  }, {
    { name = 'buffer' },
  }),
  documentation = {
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  },
  formatting = {
    format = function(entry, vim_item)
      local source = entry.source.name
      vim_item.menu = source_menu_map[source]
      return vim_item
    end,
  },
  mapping = {
    ['<C-y>'] = cmp.config.disable,
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        fn.feedkeys(t('<Plug>luasnip-jump-next'), '')
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        fn.feedkeys(t('<Plug>luasnip-jump-prev'), '')
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})
