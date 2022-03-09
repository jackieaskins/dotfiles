local M = {}

---Define vim keymap
---@param mode string
---@param lhs string
---@param rhs string | function
---@param opts? table<string, boolean>
function M.map(mode, lhs, rhs, opts)
  local options = { silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

---Define vim user command
---@param name string
---@param command string | function
---@param opts? table
function M.user_command(name, command, opts)
  local options = { force = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_add_user_command(name, command, options)
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

---Create augroup
---@param group_name string
---@param autocmds any
function M.augroup(group_name, autocmds)
  local group = vim.api.nvim_create_augroup('my_' .. group_name, {})

  for _, autocmd in ipairs(autocmds) do
    local event = autocmd[1]
    local opts = vim.tbl_extend('force', { group = group }, autocmd[2])

    vim.api.nvim_create_autocmd(event, opts)
  end
end

---Determine if a file exists
---@param filename string
---@return boolean
function M.file_exists(filename)
  return vim.fn.empty(vim.fn.glob(filename)) == 0
end

---Determine if a provided path is ececutable
---@param path string
---@return boolean
function M.is_executable(path)
  return vim.fn.executable(path) == 1
end

return M
