local M = {}

---Import and parse json file
---@param filepath string
---@return table
function M.import_json_file(filepath)
  local file = io.open(vim.fn.expand(filepath), 'r')
  assert(file)

  local file_contents = file:read('*a')
  local json = vim.json.decode(file_contents)
  file:close()

  return json
end

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

---Define vim user command
---@param name string
---@param command string | fun(arg: vim.api.keyset.create_user_command.command_args)
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

---Replace terminal codes in string with internal representation
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

---@class AutoCmd: vim.api.keyset.create_autocmd
---@field [1] vim.api.keyset.events | vim.api.keyset.events[]

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

---Debounce a function for ms
---@param fn function
---@param ms integer
---@return function
function M.debounce(fn, ms)
  local timer = vim.uv.new_timer()
  assert(timer)

  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

---Get the current snippet engine
---@return 'nvim' | 'luasnip'
function M.get_snippet_engine()
  return 'luasnip'
end

local snippet_fns = {
  nvim = {
    expand = function(input)
      vim.snippet.expand(input)
    end,
    stop = vim.snippet.stop,
  },
  luasnip = {
    expand = function(input)
      require('luasnip').lsp_expand(input)
    end,
    stop = vim.cmd.LuaSnipUnlinkCurrent,
  },
}

--- Expand snippet using current snippet engine
---@param input string
function M.snippet_expand(input)
  local snippet_engine = M.get_snippet_engine()
  snippet_fns[snippet_engine].expand(input)
end

function M.snippet_stop()
  local snippet_engine = M.get_snippet_engine()
  snippet_fns[snippet_engine].stop()
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
