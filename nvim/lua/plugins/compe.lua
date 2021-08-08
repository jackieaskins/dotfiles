local fn = vim.fn
local utils = require('utils')
local map, t = utils.map, utils.t
local luasnip = require('luasnip')

vim.opt.completeopt = 'menuone,noselect'

require('compe').setup({
  enabled = true,
  source = {
    buffer = true,
    calc = true,
    luasnip = true,
    nvim_lsp = true,
    path = true,
  },
})

local compe_opts = { silent = true, expr = true }
map('i', '<CR>', 'compe#confirm("<CR>")', compe_opts)
map('i', '<C-f>', 'compe#scroll({ "delta": +4 })', compe_opts)
map('i', '<C-b>', 'compe#scroll({ "delta": -4 })', compe_opts)

_G.tab_complete = function()
  if luasnip.jumpable(1) then
    return t('<Plug>luasnip-jump-next')
  end

  if fn.pumvisible() == 1 then
    return t('<C-n>')
  end

  return t('<Tab>')
end

_G.s_tab_complete = function()
  if luasnip.jumpable(-1) then
    return t('<Plug>luasnip-jump-prev')
  end

  if fn.pumvisible() == 1 then
    return t('<C-p>')
  end

  return t('<S-Tab>')
end

local snip_opts = { silent = true, expr = true, noremap = false }
map('i', '<Tab>', 'v:lua.tab_complete()', snip_opts)
map('s', '<Tab>', 'v:lua.tab_complete()', snip_opts)
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', snip_opts)
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', snip_opts)
