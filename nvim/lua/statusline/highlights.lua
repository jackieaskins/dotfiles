local colors = require'colors'
local utils = require'utils'

local ACTIVE_HIGHLIGHT = 'StatusLine'
local INACTIVE_HIGHLIGHT = 'StatusLineNC'

local M = {}

local function define_highlight(prefix, suffix, fg, bg, opts)
  fg = fg or colors.white
  bg = bg or colors.colorcolumn_gray
  opts = opts or 'none'

  local name = prefix .. suffix

  utils.highlight(name, {guifg = fg, guibg = bg, gui = opts})

  return '%#' .. name .. '#'
end

function M.define_active(name, fg, bg, opts)
  return define_highlight(ACTIVE_HIGHLIGHT, name, fg, bg, opts)
end

function M.define_inactive(name, fg, bg, opts)
  fg = fg or colors.gray
  return define_highlight(INACTIVE_HIGHLIGHT, name, fg, bg, opts)
end

return M
