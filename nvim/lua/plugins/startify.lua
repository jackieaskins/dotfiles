local g = vim.g
local fn = vim.fn

function _G.webDevIcons(path)
  local filename = vim.fn.fnamemodify(path, ':t')
  local extension = vim.fn.fnamemodify(path, ':e')
  return require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
end

vim.api.nvim_exec([[
  function! StartifyEntryFormat()
    return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
  endfunction
]], true)

g.startify_change_to_dir = 0
g.startify_custom_indices = fn.map(
  fn.range(0, 100),
  'v:val < 10 ? 0 . string(v:val) : string(v:val)'
)
g.startify_lists = {
  {type = 'dir', header = {' MRU in ' .. vim.fn.getcwd()}},
  {type = 'files', header = {' MRU'}}
}
