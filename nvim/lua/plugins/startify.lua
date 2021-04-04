local g = vim.g
local fn = vim.fn

g.startify_change_to_dir = 0
g.startify_custom_indices = fn.map(
  fn.range(0, 100),
  'v:val < 10 ? 0 . string(v:val) : string(v:val)'
)
g.startify_lists = {
  {type = 'dir', header = {' MRU in ' .. vim.fn.getcwd()}},
  {type = 'files', header = {'MRU'}}
}
