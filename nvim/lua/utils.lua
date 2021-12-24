local api = vim.api
local fn = vim.fn

local M = {}

---Define vim keymap
---@param mode string
---@param lhs string
---@param rhs string
---@param opts? table<string, boolean>
function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

---Replace terminal codes in strng with internal representation
---@param str string
---@return string
function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

---@class HighlightMap
---@field guifg? string
---@field guibg? string
---@field gui? string
---@field sp? string

---Generate vim highlight string
---@param name string
---@param highlight_map HighlightMap
---@return string
function M.get_highlight_string(name, highlight_map)
  local highlight_string = { 'highlight', name }
  highlight_map = highlight_map or {}

  for k, v in pairs(highlight_map) do
    table.insert(highlight_string, string.format('%s=%s', k, v))
  end

  return table.concat(highlight_string, ' ')
end

---Create vim highlight
---@param name string
---@param highlight_map HighlightMap
function M.highlight(name, highlight_map)
  vim.cmd(M.get_highlight_string(name, highlight_map))
end

---Define a vim autogroup
---@param group_name string
---@param autocmds string[][]
---@param buf boolean
local function define_augroup(group_name, autocmds, buf)
  api.nvim_command('augroup my_' .. group_name)

  local suffix = ''
  if buf then
    suffix = ' * <buffer>'
  end
  api.nvim_command('autocmd!' .. suffix)

  for _, autocmd in ipairs(autocmds) do
    api.nvim_command('autocmd ' .. table.concat(autocmd, ' '))
  end

  api.nvim_command('augroup END')
end

---Define a global vim autogroup
---@param group_name string
---@param autocmds string[][]
function M.augroup(group_name, autocmds)
  define_augroup(group_name, autocmds, false)
end

---Define a buffer autogroup
---@param group_name string
---@param autocmds string[][]
function M.augroup_buf(group_name, autocmds)
  define_augroup(group_name, autocmds, true)
end

---Determine if a file exists
---@param filename string
---@return boolean
function M.file_exists(filename)
  return fn.empty(fn.glob(filename)) == 0
end

---Determine if a provided path is ececutable
---@param path string
---@return boolean
function M.is_executable(path)
  return fn.executable(path) == 1
end

return M
