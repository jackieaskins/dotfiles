local map = require('utils').map
local env,g = vim.env,vim.g

vim.cmd [[
  command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, &columns > 80 ? fzf#vim#with_preview() : {}, <bang>0)
]]

map('n', '<C-p>', ':Files<CR>')
map('n', '<leader>/', ':Rg<CR>')
map('n', '<leader>f', ':Rg<space><C-r><C-w><CR>')
map('n', '<leader>gs', ':Gfiles?<CR>')

local fzf_mappings = {
  'ctrl-f:preview-page-down',
  'ctrl-b:preview-page-up',
  'ctrl-j:page-down',
  'ctrl-k:page-up',
  'ctrl-a:select-all',
  '?:toggle-preview'
}
local fzf_opts = {
  env.FZF_DEFAULT_OPTS or '',
  ' --layout=reverse',
  ' --bind=', table.concat(fzf_mappings, ',')
}

env.FZF_DEFAULT_OPTS = table.concat(fzf_opts, '')

g.fzf_layout = {
  window = {
    width = 0.9,
    height = 0.8,
  },
}

g.fzf_colors = {
  border = {'fg', 'Directory'},
  gutter = {'bg', 'Normal'},
  marker = {'fg', 'Identifier'},
  pointer = {'fg', 'Identifier'},
}

-- TODO: Figure out a better solution
vim.api.nvim_exec([[
  function! BuildQuickfixList(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  let g:fzf_action = { 'ctrl-q': function('BuildQuickfixList'), 'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit' }
]], true)
