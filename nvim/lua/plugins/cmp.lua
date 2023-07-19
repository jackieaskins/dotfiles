local M = {
  'hrsh7th/nvim-cmp',
  dependencies = {
    {
      'jackieaskins/cmp-emmet',
      enabled = not require('lsp.utils').is_server_supported('emmet_language_server'),
      build = 'npm run release',
    },
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-calc',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
  },
}

function M.config()
  local cmp = require('cmp')

  local source_menu_map = {
    calc = 'calc',
    emmet = 'emmet',
    luasnip = 'snip',
    nvim_lsp = 'lsp',
    buffer = 'buff',
    path = 'path',
    nvim_lsp_signature_help = 'sig',
  }

  vim.opt.completeopt = 'menu,menuone,noselect'

  cmp.setup({
    preselect = cmp.PreselectMode.Item,
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    -- Order dictates priority
    sources = cmp.config.sources({
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'emmet' },
      { name = 'path' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'calc' },
    }, {
      { name = 'buffer', option = { get_bufnrs = vim.api.nvim_list_bufs } },
    }),
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      format = function(entry, vim_item)
        local source = entry.source.name

        vim_item.menu = source_menu_map[source]
        if source == 'nvim_lsp' then
          pcall(function()
            vim_item.menu = require('lsp.utils').get_server_display_name(entry.source.source.client.name)
          end)
        end

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
        cmp.mapping.complete({ config = { sources = { { name = 'nvim_lsp' } } } }),
        { 'i', 'c' }
      ),
      ['<C-E>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
      ['<C-Y>'] = cmp.mapping(
        cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        { 'i', 'c' }
      ),
    },
  })

  cmp.setup.cmdline(':', { sources = { { name = 'cmdline' } } })
  cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } })
end

return M
