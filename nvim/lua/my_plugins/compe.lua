local utils = require 'my_utils'
local map, t = utils.map, utils.t
local opt = vim.opt

opt.completeopt = 'menu,menuone,noselect'

require'compe'.setup {
  enabled = true,
  documentation = {border = 'single'},
  source = {buffer = true, nvim_lsp = true, nvim_lua = true, vsnip = true},
}

local compe_opts = {silent = true, expr = true}
map('i', '<C-Space>', 'compe#complete()', compe_opts)
map('i', '<C-e>', 'compe#close("<C-e>")', compe_opts)
map('i', '<C-f>', 'compe#scroll({ "delta": +4 })', compe_opts)
map('i', '<C-b>', 'compe#scroll({ "delta": -4 })', compe_opts)

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

_G.tab_complete = function()
  if vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  end
end

_G.s_tab_complete = function()
  if vim.fn['vsnip#jumpable'](-1) == 1 then return t "<Plug>(vsnip-jump-prev)" end
  return t "<S-Tab>"
end

local vsnip_opts = {expr = true, silent = true, noremap = false}
map('i', '<Tab>', 'v:lua.tab_complete()', vsnip_opts)
map('s', '<Tab>', 'v:lua.tab_complete()', vsnip_opts)
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', vsnip_opts)
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', vsnip_opts)
vim.g['vsnip_snippet_dir'] = vim.fn.expand("$HOME/dotfiles/vim-common/snippets/")
