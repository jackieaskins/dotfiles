local border_config = { border = MY_CONFIG.border_style }

---@type LazySpec
return {
  { 'JezerM/oil-lsp-diagnostics.nvim', ft = 'oil', opts = {} },
  {
    'FerretDetective/oil-git-signs.nvim',
    ft = 'oil',
    ---@module 'oil_git_signs'
    ---@type oil_git_signs.Config
    opts = {},
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      confirmation = border_config,
      float = border_config,
      keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['<C-p>'] = false,
        ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
        gp = 'actions.preview',
        gr = 'actions.refresh',
      },
      keymaps_help = border_config,
      progress = border_config,
      ssh = border_config,
      win_options = {
        number = false,
        relativenumber = false,
        signcolumn = 'yes:2',
      },
      view_options = {
        is_hidden_file = function()
          return false
        end,
      },
    },
    dependencies = { 'nvim-mini/mini.icons' },
    lazy = false,
    keys = {
      { '-', '<cmd>Oil<CR>' },
      { '_', '<cmd>Oil .<CR>' },
    },
    init = function()
      local utils = require('utils')

      utils.augroup('oil', {
        {
          'User',
          pattern = 'OilActionsPost',
          callback = function(args)
            local actions = args.data.actions --[=[@as oil.Action[]]=]

            for _, action in ipairs(actions) do
              if action.type == 'delete' then
                local _, path = require('oil.util').parse_url(action.url)
                Snacks.bufdelete({ file = path, force = true })
              end
            end
          end,
        },
      })
    end,
  },
}
