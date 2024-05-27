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

---@param mode_label string
---@param highlight_name string
---@return string
local function get_mode_highlight_name(mode_label, highlight_name)
  return highlight_name .. mode_label:lower():gsub('^%l', string.upper) .. 'Mode'
end

---@param mode_color string
---@return table<string, CtpHighlight>
local function get_highlight_maps(mode_color)
  local colors = require('colors').get_colors()

  return {
    WinBarFile = { fg = mode_color },
    StatusLineMode = { fg = colors.base, bg = mode_color, style = { 'bold' } },
    StatusLineSection = { fg = mode_color, bg = colors.surface0 },
    TabLineSel = { fg = colors.base, bg = mode_color },
    NvimSeparator = { fg = mode_color },
    CursorLineNr = { fg = mode_color, style = { 'bold' } },
    ['@ibl.scope.char.1'] = { fg = mode_color },
  }
end

---@type string[]
local highlight_names = vim.tbl_keys(get_highlight_maps(''))

local M = {}

---Get the label for the current mode
---@return string
function M.get_label()
  local mode = vim.fn.mode()
  return label_map[mode] or mode
end

---Returns a table linking all defined highlight names to the corresponding mode color
---Also sets up an initial link for each highlight name to normal mode
---@param colors CtpColors
---@return table<string, CtpHighlight>
function M.get_initial_highlights(colors)
  local highlights = {}

  for mode, color_name in pairs(color_map) do
    local mode_color = colors[color_name]

    for hl_name, hl_opts in pairs(get_highlight_maps(mode_color)) do
      local mode_hl_name = get_mode_highlight_name(mode, hl_name)

      highlights[mode_hl_name] = hl_opts
      if mode == 'NORMAL' then
        highlights[hl_name] = { link = mode_hl_name }
      end
    end
  end

  return highlights
end

---Links each highlight to its corresponding mode highlight
function M.relink_highlights()
  local mode_label = M.get_label()

  for _, hl_name in ipairs(highlight_names) do
    require('utils').highlight(hl_name, {
      link = get_mode_highlight_name(mode_label, hl_name),
    })
  end
end

return M
