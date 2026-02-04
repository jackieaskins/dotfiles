---@type LazySpec
return {
  'johmsalas/text-case.nvim',
  event = 'VeryLazy',
  config = function()
    require('textcase').setup()
  end,
}
