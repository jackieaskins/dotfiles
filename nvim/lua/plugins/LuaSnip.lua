return {
  'L3MON4D3/LuaSnip',
  keys = {
    {
      '<C-Y>',
      function()
        require('luasnip').expand()
      end,
      desc = 'Expand snippet',
      mode = 'i',
    },
    {
      '<C-J>',
      function()
        require('luasnip').expand_or_jump()
      end,
      mode = { 'i', 's' },
      desc = 'Expand snippet or jump to next placeholder',
    },
    {
      '<C-K>',
      function()
        require('luasnip').jump(-1)
      end,
      mode = { 'i', 's' },
      desc = 'Jump to previous placeholder',
    },
  },
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
