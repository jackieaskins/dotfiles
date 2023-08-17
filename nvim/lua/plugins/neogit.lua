return {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'sindrets/diffview.nvim', -- optional
  },
  opts = {
    kind = 'auto',
    signs = {
      item = { '', '' },
      section = { '', '' },
    },
  },
}
