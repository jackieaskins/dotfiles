local api = vim.api
local cmp = require('cmp')
local luasnip = require('luasnip')

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
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'calc' },
  }, {
    {
      name = 'buffer',
      get_bufnrs = function()
        -- Gets visible buffers
        local bufs = {}
        for _, win in ipairs(api.nvim_list_wins()) do
          bufs[api.nvim_win_get_buf(win)] = true
        end
        return vim.tbl_keys(bufs)
      end,
    },
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
    ['<C-B>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-F>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-E>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-Y>'] = cmp.mapping.confirm({
      select = false,
      behavior = cmp.ConfirmBehavior.Replace,
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
