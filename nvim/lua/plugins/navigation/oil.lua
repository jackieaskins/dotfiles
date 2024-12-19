---@type LazySpec
return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    confirmation = { border = MY_CONFIG.border_style },
    float = { border = MY_CONFIG.border_style },
    keymaps = {
      ['<C-h>'] = false,
      ['<C-l>'] = false,
      ['<C-p>'] = false,
      ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
      ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
      gp = 'actions.preview',
      gr = 'actions.refresh',
    },
    keymaps_help = { border = MY_CONFIG.border_style },
    progress = { border = MY_CONFIG.border_style },
    ssh = { border = MY_CONFIG.border_style },
    view_options = {
      show_hidden = true,
    },
  },
  dependencies = 'echasnovski/mini.icons',
  lazy = false,
  keys = { { '-', '<cmd>Oil<CR>' } },
}
