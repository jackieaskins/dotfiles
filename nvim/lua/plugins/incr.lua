---@type LazySpec
return {
  'daliusd/incr.nvim',
  config = function()
    require('incr').setup({ incr_key = '<CR>', decr_key = '<BS>' })
  end,
}
