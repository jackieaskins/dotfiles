local function key_map(map)
  local key, fn, args, desc, mode = unpack(map)

  return {
    key,
    function()
      require('luasnip')[fn](args)
    end,
    desc = desc,
    mode = mode,
  }
end

return {
  'L3MON4D3/LuaSnip',
  build = 'make install_jsregexp',
  lazy = false,
  keys = vim.tbl_map(key_map, {
    { '<C-y>', 'expand', nil, 'Expand snippet', 'i' },
    { '<C-j>', 'expand_or_jump', nil, 'Expand snippet or jump to next placeholder', { 'i', 's' } },
    { '<C-k>', 'jump', -1, 'Jump to previous placeholder', { 'i', 's' } },
  }),
  config = function()
    require('luasnip').config.set_config({ updateevents = 'TextChanged,TextChangedI' })

    require('luasnip.loaders.from_vscode').lazy_load({
      paths = { '~/dotfiles/vim-common' },
    })
  end,
}
