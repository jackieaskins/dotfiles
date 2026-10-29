---@type LazySpec
return {
  'dmmulroy/tsc.nvim',
  cmd = 'TSC',
  config = function()
    require('tsc').setup({
      pretty_errors = false,
      ---@diagnostic disable-next-line: assign-type-mismatch
      flags = '--build --noEmit',
    })
  end,
}
