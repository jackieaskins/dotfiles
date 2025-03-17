---@type LazySpec
return {
  'L3MON4D3/LuaSnip',
  enabled = require('utils').get_snippet_engine() == 'luasnip',
  build = 'make install_jsregexp',
  config = function()
    require('luasnip').config.set_config({
      updateevents = 'TextChanged,TextChangedI',
    })

    require('luasnip.loaders.from_vscode').lazy_load({
      paths = {
        '~/dotfiles/nvim/snippets',
      },
    })
  end,
}
