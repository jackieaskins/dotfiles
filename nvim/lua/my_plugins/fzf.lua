local map = require('my_utils').map
local cmd, env, fn, g = vim.cmd, vim.env, vim.fn, vim.g

vim.cmd [[
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, &columns > 80 ? fzf#vim#with_preview() : {}, <bang>0)
]]

map('n', '<C-p>', ':Files<CR>')
map('n', '<leader>/', ':Rg<space>')
map('n', '<leader>f', ':Rg<space><C-r><C-w><CR>')
map('n', '<leader>gs', ':GFiles?<CR>')

local fzf_mappings = {
  'ctrl-f:preview-page-down',
  'ctrl-b:preview-page-up',
  'ctrl-j:page-down',
  'ctrl-k:page-up',
  'ctrl-a:select-all',
  '?:toggle-preview',
}
local fzf_opts = {
  env.FZF_DEFAULT_OPTS or '',
  ' --layout=reverse',
  ' --bind=',
  table.concat(fzf_mappings, ','),
}
env.FZF_DEFAULT_OPTS = table.concat(fzf_opts, '')

g.fzf_layout = {window = {width = 0.9, height = 0.8}}
g.fzf_colors = {
  border = {'fg', 'Directory'},
  gutter = {'bg', 'Normal'},
  marker = {'fg', 'Identifier'},
  pointer = {'fg', 'Identifier'},
}
g.fzf_action = {
  ['ctrl-q'] = function(lines)
    fn.setqflist(fn.map(fn.copy(lines), '{"filename": v:val}'))
    cmd 'copen'
    cmd 'cc'
  end,
  ['ctrl-s'] = function(lines)
    for _, line in ipairs(lines) do os.execute('git add ' .. line) end
    cmd 'Git'
  end,
  ['ctrl-t'] = 'tab split',
  ['ctrl-x'] = 'split',
  ['ctrl-v'] = 'vsplit',
}
