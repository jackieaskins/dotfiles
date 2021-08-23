local fn = vim.fn
local cmp = require('cmp')
local t = require('utils').t

require('cmp_nvim_lsp').setup()

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  sources = {
    { name = 'calc' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'vsnip' },
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.prev_item(),
    ['<C-n>'] = cmp.mapping.next_item(),
    ['<C-b>'] = cmp.mapping.scroll(-4),
    ['<C-f>'] = cmp.mapping.scroll(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ['<Tab>'] = cmp.mapping.mode({ 'i', 's' }, function(_, fallback)
      if fn['vsnip#jumpable'](1) == 1 then
        fn.feedkeys(t('<Plug>(vsnip-jump-next)'), '')
      else
        fallback()
      end
    end),
    ['<S-Tab>'] = cmp.mapping.mode({ 'i', 's' }, function(_, fallback)
      if fn['vsnip#jumpable'](-1) == 1 then
        fn.feedkeys(t('<Plug>(vsnip-jump-prev)'), '')
      else
        fallback()
      end
    end),
  },
})
