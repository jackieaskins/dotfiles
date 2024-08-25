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
    { 'onsails/lspkind.nvim' },
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
      ---@diagnostic disable-next-line: missing-fields
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
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        format = function(entry, vim_item)
          local color_item = require('nvim-highlight-colors').format(entry, {
            kind = vim_item.kind,
          })

          vim_item = require('lspkind').cmp_format({
            maxwidth = 50,
            before = function(e, item)
              local source = e.source.name

              item.menu = source_menu_map[source]
              if source == 'nvim_lsp' then
                pcall(function()
                  local utils = require('lsp.utils')
                  item.menu = '[' .. utils.get_server_display_name(e.source.source.client.name) .. ']'
                end)
              end

              return item
            end,
          })(entry, vim_item)

          if color_item.abbr_hl_group then
            vim_item.kind_hl_group = color_item.abbr_hl_group
          end

          return vim_item
        end,
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
