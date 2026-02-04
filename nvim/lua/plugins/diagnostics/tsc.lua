---@type LazySpec
return {
  'dmmulroy/tsc.nvim',
  cmd = 'TSC',
  config = function()
    require('tsc').setup({
      pretty_errors = false,
    })
  end,
}
