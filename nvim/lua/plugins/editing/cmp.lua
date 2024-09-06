local colors = require('colors').get_colors()

local lspkind_icons = {
  Class = '󰠱',
  Color = '󰏘',
  Constant = '󰏿',
  Constructor = '',
  Enum = '',
  EnumMember = '',
  Event = '',
  Field = '󰜢',
  File = '󰈙',
  Folder = '󰉋',
  Function = '󰊕',
  Interface = '',
  Keyword = '󰌋',
  Method = '󰆧',
  Module = '',
  Operator = '',
  Property = '',
  Reference = '󰈇',
  Snippet = '',
  Struct = '󰙅',
  Text = '󰉿',
  TypeParameter = '',
  Unit = '',
  Value = '󰎠',
  Variable = '󰀫',
}
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

---@type LazySpec
return {
  'hrsh7th/nvim-cmp',
  event = 'VeryLazy',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-calc',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-path',
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
      view = { entries = { follow_cursor = true, name = 'custom' } },
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
        expandable_indicator = true,
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          local source = entry.source.name
          local client_name = source == 'nvim_lsp'
              and require('lsp.utils').get_server_display_name(entry.source.source.client.name)
            or nil

          vim_item.menu = vim_item.menu and vim_item.menu or client_name or source_menu_map[source]
          if vim_item.menu then
            vim_item.menu = ' ' .. vim_item.menu
          end

          local color_item = require('nvim-highlight-colors').format(entry, { kind = vim_item.kind })
          if color_item.abbr_hl_group then
            vim_item.kind_hl_group = color_item.abbr_hl_group
            vim_item.kind = color_item.abbr
          else
            vim_item.kind = lspkind_icons[vim_item.kind] or ''
          end
          vim_item.kind = vim_item.kind .. ' '

          local color = colors[vim_item.abbr]
          if client_name == 'lua_ls' and color then
            vim_item.abbr = vim_item.abbr .. ' ' .. color
          end
          vim_item.abbr = vim_item.abbr:sub(1, 50)

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

    local cmdline_formatting = { fields = { 'abbr' } }
    cmp.setup.cmdline(':', { formatting = cmdline_formatting, sources = { { name = 'cmdline' } } })
    cmp.setup.cmdline('/', { formatting = cmdline_formatting, sources = { { name = 'buffer' } } })
  end,
}
