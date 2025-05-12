local border_config = { border = MY_CONFIG.border_style }

---@type LazySpec
return {
  { 'JezerM/oil-lsp-diagnostics.nvim', ft = 'oil', opts = {} },
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
    dependencies = {
      'echasnovski/mini.icons',
    },
    lazy = false,
    keys = {
      { '-', '<cmd>Oil<CR>' },
      { '_', '<cmd>Oil .<CR>' },
    },
    init = function()
      local utils = require('utils')
      local git_oil = require('plugins.navigation.oil.git')

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
        {
          'User',
          pattern = 'OilMutationComplete',
          callback = function(args)
            git_oil.load_git_signs(args.buf)
          end,
        },
        {
          'FileType',
          pattern = 'oil',
          callback = function(args)
            local buf = args.buf

            if vim.b[buf].git_signs_configured then
              return
            end

            vim.b[buf].git_signs_configured = true

            utils.augroup('oil-git-signs-buf-' .. buf, {
              {
                'BufReadPost',
                buffer = buf,
                callback = function()
                  git_oil.load_git_signs(buf)
                end,
              },
              {
                { 'InsertLeave', 'TextChanged' },
                buffer = buf,
                callback = function()
                  git_oil.set_signs(buf)
                end,
              },
            })
          end,
        },
      })
    end,
  },
}
