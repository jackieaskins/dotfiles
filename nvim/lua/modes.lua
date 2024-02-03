-- Borrowed from https://github.com/freddiehaddad/feline.nvim/blob/main/lua/feline/providers/vi_mode.lua
local label_map = {
  ['n'] = 'NORMAL',
  ['no'] = 'OP',
  ['nov'] = 'OP',
  ['noV'] = 'OP',
  ['no'] = 'OP',
  ['niI'] = 'NORMAL',
  ['niR'] = 'NORMAL',
  ['niV'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['vs'] = 'VISUAL',
  ['V'] = 'LINES',
  ['Vs'] = 'LINES',
  [''] = 'BLOCK',
  ['s'] = 'BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'SELECT',
  [''] = 'BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['ix'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rc'] = 'REPLACE',
  ['Rv'] = 'V-REPLACE',
  ['Rx'] = 'REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'COMMAND',
  ['ce'] = 'COMMAND',
  ['r'] = 'ENTER',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERM',
  ['nt'] = 'TERM',
  ['null'] = 'NONE',
}

local color_map = {
  NORMAL = 'blue',
  OP = 'blue',
  VISUAL = 'teal',
  LINES = 'teal',
  BLOCK = 'teal',
  SELECT = 'teal',
  INSERT = 'green',
  REPLACE = 'maroon',
  ['V-REPLACE'] = 'maroon',
  ENTER = 'peach',
  MORE = 'peach',
  COMMAND = 'peach',
  SHELL = 'peach',
  TERM = 'peach',
  NONE = 'mauve',
}

local M = {}

function M.get_label()
  local mode = vim.fn.mode()
  return label_map[mode] or mode
end

function M.get_color()
  local color = color_map[M.get_label()] or 'text'
  return require('colors').get_colors()[color]
end

return M
