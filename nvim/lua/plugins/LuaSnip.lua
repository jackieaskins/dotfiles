-- https://github.com/L3MON4D3/LuaSnip

local map = require('utils').map
local luasnip = require('luasnip')
local snippet = luasnip.snippet
local snippet_node = luasnip.snippet_node
local dynamic_node = luasnip.dynamic_node
local insert_node = luasnip.insert_node
local text_node = luasnip.text_node
local fmt = require('luasnip.extras.fmt').fmt

require('luasnip/loaders/from_vscode').load({
  paths = { '~/dotfiles/vim-common' },
})

map({ 'i', 's' }, '<C-J>', luasnip.expand_or_jump, { desc = 'Expand snippet or jump to next placeholder' })
map({ 'i', 's' }, '<C-K>', function()
  luasnip.jump(-1)
end, { desc = 'Jump to previous placeholder' })

luasnip.config.set_config({
  updateevents = 'TextChanged,TextChangedI',
})

local snippets = {}

snippets.typescriptreact = {
  snippet(
    'us',
    fmt('const [{state}, set{State}] = useState{type}({init});', {
      state = insert_node(1),
      State = dynamic_node(2, function(args)
        return snippet_node(nil, text_node(args[1][1]:gsub('^%l', string.upper)))
      end, { 1 }),
      type = insert_node(3),
      init = insert_node(4),
    })
  ),
}

luasnip.snippets = snippets
