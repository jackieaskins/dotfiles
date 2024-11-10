---@type LazySpec
return {
  'm4xshen/autoclose.nvim',
  opts = {
    keys = {
      ['>'] = { escape = true, close = false, pair = '><' },
      ['`'] = { escape = false, close = true, pair = '``' },
    },
    options = { pair_spaces = true },
  },
}
