local colors = require 'my_colors'
local utils = require 'my_utils'

local ACTIVE_HIGHLIGHT = 'StatusLine'
local INACTIVE_HIGHLIGHT = 'StatusLineNC'

local M = {}

local function define_highlight(prefix, suffix, fg, bg, opts)
  fg = fg or colors.default_fg
  bg = bg or colors.gray1
  opts = opts or 'none'

  local name = prefix .. suffix

  utils.highlight(name, {guifg = fg, guibg = bg, gui = opts})

  return '%#' .. name .. '#'
end

function M.define_active(name, fg, bg, opts)
  return define_highlight(ACTIVE_HIGHLIGHT, name, fg, bg, opts)
end

function M.define_inactive(name, fg, bg, opts)
  fg = fg or colors.gray3
  return define_highlight(INACTIVE_HIGHLIGHT, name, fg, bg, opts)
end

return M
