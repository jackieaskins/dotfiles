local api = vim.api

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

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.get_highlight_string(name, highlight_map)
  local highlight_string = {'highlight', name}
  highlight_map = highlight_map or {}

  for k, v in pairs(highlight_map) do
    table.insert(highlight_string, string.format('%s=%s', k, v))
  end

  return table.concat(highlight_string, ' ')
end

function M.highlight(name, highlight_map)
  vim.cmd(M.get_highlight_string(name, highlight_map))
end

function M.augroup(group_name, autocmds)
  api.nvim_command('augroup my_' .. group_name)
  api.nvim_command('autocmd!')

  for _, autocmd in ipairs(autocmds) do
    api.nvim_command('autocmd ' .. table.concat(autocmd, ' '))
  end

  api.nvim_command('augroup END')
end

return M
