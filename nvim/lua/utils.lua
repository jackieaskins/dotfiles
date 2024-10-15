local M = {}

---@alias map_fn fun(mode: string | string[], lhs: string, rhs: string | function, opts?: vim.keymap.set.Opts)

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

---@class UserCommandArg
---@field name string Command name
---@field args string The args passed to the command, if any <args>
---@field fargs table The args split by unescaped whitespace (when more than one argument is allowed), if any <f-args>
---@field nargs string Number of arguments |:command-nargs|
---@field bang boolean "true" if the command was executed with a ! modifier <bang>
---@field line1 number The starting line of the command range <line1>
---@field line2 number The final line of the command range <line2>
---@field range number The number of items in the command range: 0, 1, or 2 <range>
---@field count number Any count supplied <count>
---@field reg string The optional register, if specified <reg>
---@field mods string Command modifiers, if any <mods>
---@field smods table Command modifiers in a structured format. Has the same structure as the "mods" key of |nvim_parse_cmd()|.

---Define vim user command
---@param name string
---@param command string | fun(arg: UserCommandArg)
---@param opts? vim.api.keyset.user_command
function M.user_command(name, command, opts)
  local options = { force = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_create_user_command(name, command, options)
end

---Define vim buf user command
---@param buffer integer
---@param name string
---@param command string | function
---@param opts? vim.api.keyset.user_command
function M.buf_user_command(buffer, name, command, opts)
  local options = { force = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_buf_create_user_command(buffer, name, command, options)
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
---@generic T
---@param table table<string, T>
---@param keys string[]
---@return table<string, T>
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
---@return 'nvim'
function M.get_snippet_engine()
  return 'nvim'
end

--- Expand snippet using current snippet engine
---@param input string
function M.snippet_expand(input)
  if M.get_snippet_engine() == 'nvim' then
    vim.snippet.expand(input)
  end
end

---Maps from a table to list
---@generic K : string
---@generic V
---@generic R
---@param fn fun(value: V, key: K): R
---@param tbl table<K, V>
---@return R[]
function M.map_table_to_list(fn, tbl)
  local list = {}

  for key, value in pairs(tbl) do
    table.insert(list, fn(value, key))
  end

  return list
end

---Maps from a table to another table
---@generic K : string
---@generic V
---@generic RK
---@generic RV
---@param fn fun(value: V, key: K): RK, RV
---@param tbl table<K, V>
---@return table<RK, RV>
function M.map_table_to_table(fn, tbl)
  local out_tbl = {}

  for key, value in pairs(tbl) do
    local k, v = fn(value, key)
    out_tbl[k] = v
  end

  return out_tbl
end

return M
