local utils = require('utils')
local augroup, map = utils.augroup, utils.map

local load = require('packer').loader

load('fern-git-status.vim')
vim.fn['fern_git_status#init']()

vim.g['fern#disable_default_mappings'] = 1
vim.g['fern#drawer_width'] = 50
vim.g['fern#default_hidden'] = 1
vim.g['fern#hide_cursor'] = 1
vim.g['fern#renderer'] = 'nerdfont'
vim.g['fern_git_status#disable_ignored'] = 1

map('n', '<Plug>(fern-custom-action-close-drawer)', ':<C-u>FernDo close<CR>')
map(
  'n',
  '<Plug>(fern-custom-action-open-and-close)',
  '<Plug>(fern-action-open) <Plug>(fern-custom-action-close-drawer)',
  { noremap = false }
)
map(
  'n',
  '<Plug>(fern-custom-action-smart-open)',
  table.concat({
    'fern#smart#leaf(',
    '"<Plug>(fern-custom-action-open-and-close)",',
    '"<Plug>(fern-action-expand)",',
    '"<Plug>(fern-action-collapse)"',
    ')',
  }, ''),
  { noremap = false, expr = true }
)

local function bsk(lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(
    0,
    'n',
    lhs,
    rhs,
    vim.tbl_extend('force', {
      silent = true,
      nowait = true,
    }, opts or {})
  )
end

function _G.InitFern()
  bsk('q', '<Plug>(fern-custom-action-close-drawer)')
  bsk('R', '<Plug>(fern-action-reload:all)')

  bsk('o', '<Plug>(fern-custom-action-smart-open)')
  bsk('<CR>', '<Plug>(fern-custom-action-smart-open)')
  bsk('<C-v>', '<Plug>(fern-action-open:vsplit) <Plug>(fern-custom-action-close-drawer)')
  bsk('<C-x>', '<Plug>(fern-action-open:split) <Plug>(fern-custom-action-close-drawer)')
  bsk('<C-t>', '<Plug>(fern-action-open:tabedit) <Plug>(fern-custom-action-close-drawer)')
  bsk('<Tab>', '<Plug>(fern-action-open)<C-w><C-p>')

  bsk('h', '<Plug>(fern-action-collapse)')
  bsk('l', '<Plug>(fern-action-expand)')

  bsk('c', '<Plug>(fern-action-new-path)')
  bsk('m', '<Plug>(fern-action-move)')
  bsk('r', '<Plug>(fern-action-rename)')
  bsk('d', '<Plug>(fern-action-remove)')
  bsk('y', '<Plug>(fern-action-copy)')

  bsk('-', '<Plug>(fern-action-mark:toggle)')
end

augroup('init_fern', {
  { 'FileType', 'fern', 'call v:lua.InitFern()' },
  { 'FileType', 'fern', 'setlocal norelativenumber nonumber' },
})
