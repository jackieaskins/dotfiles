return {
  'Bekaboo/dropbar.nvim',
  opts = {
    icons = {
      ui = {
        bar = { separator = '  ' },
      },
    },
    sources = {
      path = {
        modified = function(sym)
          return sym:merge({
            name = sym.name .. ' [+]',
            name_hl = 'DropBarModified',
            icon_hl = 'DropBarModified',
          })
        end,
      },
    },
  },
}
