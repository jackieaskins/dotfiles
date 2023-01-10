local M = {}

---Define vim keymap
---@param mode string | table<string>
---@param lhs string
---@param rhs string | function
---@param opts? table
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
  vim.api.nvim_create_user_command(name, command, options)
end

---Replace terminal codes in strng with internal representation
---@param str string
---@return string
function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

---Create vim highlight
---@param name string
---@param highlight_map table
function M.highlight(name, highlight_map)
  vim.api.nvim_set_hl(0, name, highlight_map)
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

---Determine if a provided path is executable
---@param path string
---@return boolean
function M.is_executable(path)
  return vim.fn.executable(path) == 1
end

---Open url in browser
---@param url string
function M.open_url(url)
  local open_cmd = vim.fn.has('mac') == 1 and 'open' or 'xdg-open'
  vim.fn.system(open_cmd .. ' ' .. vim.fn.shellescape(url))
end

---Filter key-value table based on key
---@param table table<string, any>
---@param keys string[]
---@return table<string, any>
function M.filter_table_by_keys(table, keys)
  local rv = {}
  for _, key in ipairs(keys) do
    rv[key] = table[key]
  end
  return rv
end

return M
