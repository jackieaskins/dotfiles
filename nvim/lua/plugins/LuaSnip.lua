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
  keys = vim.tbl_map(key_map, {
    { '<C-y>', 'expand', nil, 'Expand snippet', 'i' },
    { '<C-j>', 'expand_or_jump', nil, 'Expand snippet or jump to next placeholder', { 'i', 's' } },
    { '<C-k>', 'jump', -1, 'Jump to previous placeholder', { 'i', 's' } },
  }),
  config = function()
    local luasnip = require('luasnip')
    local snippet = luasnip.snippet
    local snippet_node = luasnip.snippet_node
    local dynamic_node = luasnip.dynamic_node
    local insert_node = luasnip.insert_node
    local text_node = luasnip.text_node
    local fmt = require('luasnip.extras.fmt').fmt

    require('luasnip.loaders.from_vscode').lazy_load({
      paths = { '~/dotfiles/vim-common' },
    })

    luasnip.config.set_config({
      updateevents = 'TextChanged,TextChangedI',
    })

    luasnip.add_snippets('typescriptreact', {
      snippet(
        { trig = 'us', name = 'Use State', dscr = 'Use State' },
        fmt('const [{state}, set{State}] = useState{type}({init});', {
          state = insert_node(1),
          State = dynamic_node(2, function(args)
            local set_string = args[1][1]:gsub('^%l', string.upper)
            return snippet_node(nil, text_node(set_string))
          end, { 1 }),
          type = insert_node(3),
          init = insert_node(4),
        })
      ),
    })
  end,
}
