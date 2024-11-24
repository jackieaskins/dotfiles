---@type LazySpec
return {
  'andymass/vim-matchup',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'VeryLazy',
  init = function()
    vim.g.loaded_matchparen = 1
    vim.g.matchup_matchparen_offscreen = {}
    vim.g.matchup_matchparen_deferred = 1
    vim.g.matchup_matchparen_hi_surround_always = 1
  end,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup({
      matchup = {
        enable = true,
        enable_quotes = true,
        disable_virtual_text = true,
      },
    })
  end,
}
