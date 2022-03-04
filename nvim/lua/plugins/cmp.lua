-- https://github.com/hrsh7th/nvim-cmp

local api = vim.api
local cmp = require('cmp')
local luasnip = require('luasnip')

local source_menu_map = {
  luasnip = 'Snip',
  nvim_lsp = 'LSP',
  buffer = 'Buff',
  path = 'Path',
  nvim_lsp_signature_help = 'Sig',
}

vim.opt.completeopt = 'menu,menuone,noselect'

cmp.setup({
  experimental = {
    horizontal_search = true,
  },
  preselect = cmp.PreselectMode.Item,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- Order dictates priority
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'nvim_lsp_signature_help' },
  }, {
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          -- Gets visible buffers
          local bufs = {}
          for _, win in ipairs(api.nvim_list_wins()) do
            bufs[api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
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
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
  },
})

local cmdline_view = { entries = { name = 'wildmenu', separator = '  ' } }

cmp.setup.cmdline(':', {
  view = cmdline_view,
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})

cmp.setup.cmdline('/', {
  view = cmdline_view,
  sources = {
    { name = 'buffer' },
  },
})
