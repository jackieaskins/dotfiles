local cmd = vim.cmd
local colors = require'statusline/colors'

local ACTIVE_HIGHLIGHT = 'StatusLine'
local INACTIVE_HIGHLIGHT = 'StatusLineNC'

local M = {}

local function define_highlight(prefix, suffix, fg, bg, mod)
  fg = fg or colors.fg
  bg = bg or colors.bg
  mod = mod or 'none'

  cmd(string.format(
    'highlight %s%s guifg=%s guibg=%s gui=%s',
    prefix, suffix, fg, bg, mod
  ))

  return '%#' .. prefix .. suffix .. '#'
end

function M.define_active(name, fg, bg, mod)
  return define_highlight(ACTIVE_HIGHLIGHT, name, fg, bg, mod)
end

function M.define_inactive(name, fg, bg, mod)
  fg = fg or colors.inactive_fg
  return define_highlight(INACTIVE_HIGHLIGHT, name, fg, bg, mod)
end

return M
