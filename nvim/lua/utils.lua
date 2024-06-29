local M = {}

---@alias map_fn fun(mode: string | table<string>, lhs: string, rhs: string | function, opts?: table)

---Define vim keymap
---@type map_fn
function M.map(mode, lhs, rhs, opts)
  local options = { silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

---Define vim keymap for buffer
---@param bufnr number | boolean
---@return map_fn
function M.buffer_map(bufnr)
  return function(mode, lhs, rhs, opts)
    local options = { buffer = bufnr }
    if opts then
      options = vim.tbl_extend('force', options, opts)
    end
    M.map(mode, lhs, rhs, options)
  end
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
---@param highlight_map vim.api.keyset.highlight
function M.highlight(name, highlight_map)
  vim.api.nvim_set_hl(0, name, highlight_map)
end

---@class AutoCmdCallbackArgs
---@field id number
---@field event string
---@field group number | nil
---@field match string
---@field buf number
---@field file string
---@field data any

---@class AutoCmd
---@field [1] string | string[]
---@field pattern? string | string[]
---@field buffer? number
---@field desc? string
---@field callback? fun(args: AutoCmdCallbackArgs) | string
---@field command? string
---@field once? boolean
---@field nested? boolean

---Create augroup
---@param group_name string
---@param autocmds AutoCmd[]
function M.augroup(group_name, autocmds)
  local group = vim.api.nvim_create_augroup('my_' .. group_name, {})

  for _, autocmd in ipairs(autocmds) do
    local event = autocmd[1]
    local opts = vim.tbl_extend('force', { group = group }, autocmd)
    table.remove(opts, 1)

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
  vim.ui.open(url)
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

---Debounce a function for ms
---@param fn function
---@param ms number
---@return function
function M.debounce(fn, ms)
  local timer = vim.uv.new_timer()
  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

---Get the current snippet engine
---@return 'luasnip' | 'nvim'
function M.get_snippet_engine()
  return 'luasnip'
end

--- Expand snippet using current snippet engine
---@param input string
function M.snippet_expand(input)
  if M.get_snippet_engine() == 'nvim' then
    vim.snippet.expand(input)
  else
    require('luasnip').lsp_expand(input)
  end
end

return M
