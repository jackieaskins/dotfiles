local colors = require'colors'
local fn = vim.fn

local mode_map = {
  n = {color = colors.blue, label = 'NORMAL'},
  no = {color = colors.blue, label = 'NORMAL'},
  v = {color = colors.orange, label = 'VISUAL'},
  V = {color = colors.orange, label = 'VISUAL'},
  ['^V'] = {color = colors.orange, label = 'VISUAL'},
  s = {color = colors.purple, label = 'SELECT'},
  S = {color = colors.purple, label = 'SELECT'},
  ['^S'] = {color = colors.purple, label = 'SELECT'},
  i = {color = colors.green, label = 'INSERT'},
  ic = {color = colors.green, label = 'INSERT'},
  R = {color = colors.red, label = 'REPLACE'},
  Rv = {color = colors.red, label = 'REPLACE'},
  c = {color = colors.yellow, label = 'COMMAND'},
  cv = {color = colors.yellow, label = 'EX'},
  ce = {color = colors.red, label = 'EX'},
  r = {color = colors.cyan, label = 'HIT-ENTER'},
  rm = {color = colors.cyan, label = '--MORE--'},
  ['r?'] = {color = colors.cyan, label = 'CONFIRM'},
  ['!']  = {color = colors.indigo, label = 'SHELL'},
  t = {color = colors.indigo, label = 'TERMINAL'}
}

local M = {}

function M.get_color()
  local mode = fn.mode()
  return (mode_map[mode] or {color = 'yellow'}).color
end

function M.get_label()
  local mode = fn.mode()
  return (mode_map[mode] or {label = mode}).label
end

return M
