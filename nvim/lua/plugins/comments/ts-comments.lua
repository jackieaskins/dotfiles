---@type LazySpec
return {
  'folke/ts-comments.nvim',
  config = function()
    require('ts-comments').setup()
  end,
  event = 'VeryLazy',
}
