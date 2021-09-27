local fn = vim.fn
local cmp = require('cmp')
local luasnip = require('luasnip')
local t = require('utils').t

vim.opt.completeopt = 'menu,menuone,noselect'

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'buffer' },
    { name = 'calc' },
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'path' },
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
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

require('utils').augroup('cmp_filetypes', {
  {
    'FileType',
    'javascript,javascriptreact,typescript,typescriptreact',
    'lua require("cmp").setup.buffer({ completion = { keyword_length = 3 } })',
  },
  {
    'FileType',
    'dart',
    'lua require("cmp").setup.buffer({ completion = { autocomplete = false } })',
  },
})
