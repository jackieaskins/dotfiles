local border_config = { border = MY_CONFIG.border_style }

---@type LazySpec
return {
  { 'JezerM/oil-lsp-diagnostics.nvim', ft = 'oil', opts = {} },
  { 'refractalize/oil-git-status.nvim', ft = 'oil', opts = {} },
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
  },
}
