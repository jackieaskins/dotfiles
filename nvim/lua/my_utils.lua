local api = vim.api
local fn = vim.fn

local M = {}

-- https://github.com/neovim/neovim/pull/13479
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
function M.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

function M.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.t(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end

function M.get_highlight_string(name, highlight_map)
  local highlight_string = {'highlight', name}
  highlight_map = highlight_map or {}

  for k, v in pairs(highlight_map) do table.insert(highlight_string, string.format('%s=%s', k, v)) end

  return table.concat(highlight_string, ' ')
end

function M.highlight(name, highlight_map) vim.cmd(M.get_highlight_string(name, highlight_map)) end

local function define_augroup(group_name, autocmds, buf)
  api.nvim_command('augroup my_' .. group_name)

  local suffix = ''
  if buf then suffix = ' * <buffer>' end
  api.nvim_command('autocmd!' .. suffix)

  for _, autocmd in ipairs(autocmds) do api.nvim_command('autocmd ' .. table.concat(autocmd, ' ')) end

  api.nvim_command('augroup END')
end

function M.augroup(group_name, autocmds) define_augroup(group_name, autocmds, false) end

function M.augroup_buf(group_name, autocmds) define_augroup(group_name, autocmds, true) end

function M.file_exists(filename) return fn.empty(fn.glob(filename)) == 0 end

return M
