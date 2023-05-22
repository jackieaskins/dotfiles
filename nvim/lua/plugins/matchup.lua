return {
  'andymass/vim-matchup',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  init = function()
    vim.g.matchup_matchparen_offscreen = {}
  end,
  config = function()
    require('nvim-treesitter.configs').setup({
      matchup = {
        enable = true,
        enable_quotes = true,
        disable_virtual_text = true,
      },
    })
  end,
}
