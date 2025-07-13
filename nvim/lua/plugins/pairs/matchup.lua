---@type LazySpec
return {
  'andymass/vim-matchup',
  event = 'VeryLazy',
  init = function()
    vim.g.loaded_matchparen = 1
    vim.g.matchup_matchparen_offscreen = {}
    vim.g.matchup_matchparen_deferred = 1
    vim.g.matchup_matchparen_hi_surround_always = 1
    vim.g.matchup_treesitter_disable_virtual_text = 1
  end,
  ---@module 'match-up'
  ---@type matchup.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {},
}
