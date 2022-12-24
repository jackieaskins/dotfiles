return {
  'andymass/vim-matchup',
  config = function()
    require('nvim-treesitter.configs').setup({
      matchup = {
        enable = true,
        disable_virtual_text = true,
      },
    })
  end,
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  init = function()
    vim.g.matchup_matchparen_offscreen = {}
  end,
}
