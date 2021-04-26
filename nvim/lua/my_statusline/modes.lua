local colors = require'my_colors'
local fn = vim.fn

local mode_map = {
  n = {color = colors.blue, label = 'NORMAL'},
  no = {color = colors.blue, label = 'NORMAL'},
  v = {color = colors.cyan, label = 'VISUAL'},
  V = {color = colors.cyan, label = 'VISUAL'},
  ['^V'] = {color = colors.cyan, label = 'VISUAL'},
  s = {color = colors.cyan, label = 'SELECT'},
  S = {color = colors.cyan, label = 'SELECT'},
  ['^S'] = {color = colors.cyan, label = 'SELECT'},
  i = {color = colors.green, label = 'INSERT'},
  ic = {color = colors.green, label = 'INSERT'},
  R = {color = colors.red, label = 'REPLACE'},
  Rv = {color = colors.red, label = 'REPLACE'},
  c = {color = colors.yellow, label = 'COMMAND'},
  cv = {color = colors.yellow, label = 'EX'},
  ce = {color = colors.yellow, label = 'EX'},
  r = {color = colors.yellow, label = 'HIT-ENTER'},
  rm = {color = colors.yellow, label = '--MORE--'},
  ['r?'] = {color = colors.yellow, label = 'CONFIRM'},
  ['!']  = {color = colors.purple, label = 'SHELL'},
  t = {color = colors.purple, label = 'TERMINAL'}
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
