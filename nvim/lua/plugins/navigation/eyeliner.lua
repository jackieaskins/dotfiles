---@type LazySpec
return {
  'jinh0/eyeliner.nvim',
  keys = { 'f', 't', 'F', 'T' },
  config = function()
    require('eyeliner').setup({ highlight_on_key = true, dim = true })
  end,
}
