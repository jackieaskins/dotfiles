---@type LazySpec
return {
  'chrisgrieser/nvim-early-retirement',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('early-retirement').setup({})
  end,
}
