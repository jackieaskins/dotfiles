local border_config = {
  border = vim.g.border_style,
  winhighlight = 'FloatBorder:FloatBorder',
}
local source_menu_map = {
  buffer = 'buff',
  calc = 'calc',
  lazydev = 'lazy',
  luasnip = 'snip',
  nvim_lsp = 'lsp',
  nvim_lsp_signature_help = 'sig',
  path = 'path',
}

return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-calc',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-path',
    {
      'onsails/lspkind.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons', optional = true },
    },
    'folke/lazydev.nvim',
    'saadparwaiz1/cmp_luasnip',
    { 'jackieaskins/cmp-luasnip-choice', config = true },
  },
  config = function()
    local cmp = require('cmp')
    local select_behavior = { behavior = cmp.SelectBehavior.Insert }

    cmp.setup({
      preselect = cmp.PreselectMode.Item,
      snippet = {
        expand = function(args)
          require('utils').snippet_expand(args.body)
        end,
      },
      view = { entries = { follow_cursor = true } },
      -- Order dictates priority
      sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'buffer', option = { get_bufnrs = vim.api.nvim_list_bufs } },
        { name = 'calc' },
        { name = 'lazydev', group_index = 0 },
      }),
      window = {
        completion = cmp.config.window.bordered(border_config),
        documentation = cmp.config.window.bordered(border_config),
      },
      formatting = {
        format = require('lspkind').cmp_format({
          before = function(entry, vim_item)
            local source = entry.source.name

            vim_item.menu = source_menu_map[source]
            if source == 'nvim_lsp' then
              pcall(function()
                local utils = require('lsp.utils')
                vim_item.menu = '[' .. utils.get_server_display_name(entry.source.source.client.name) .. ']'
              end)
            end

            vim_item.abbr = string.sub(vim_item.abbr, 1, 50)

            return vim_item
          end,
        }),
      },
      mapping = {
        ['<C-B>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-F>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(select_behavior), { 'c' }),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(select_behavior), { 'c' }),
        ['<C-N>'] = cmp.mapping(cmp.mapping.select_next_item(select_behavior), { 'i', 'c' }),
        ['<C-P>'] = cmp.mapping(cmp.mapping.select_prev_item(select_behavior), { 'i', 'c' }),
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
  end,
}
