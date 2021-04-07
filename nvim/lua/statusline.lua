local fn = vim.fn
local bo = vim.bo
local cmd = vim.cmd

local colors = {
  bg = '#292929',
  section_bg = '#474646',
  fg = '#b7bdc0',
  subtle_fg = '#6a6c6c',
  red = '#dd7186',
  green = '#87bb7c',
  yellow = '#d5b875',
  blue = '#70ace5',
  purple = '#a48add',
  cyan = '#69c5ce',
  orange = '#d7956e',
  indigo = '#7681de',
}

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

local prefix_component = '▊ '
local spacer_component = ' '
local split_component = '%='
local suffix_component = ' ▊'

local function create_highlight(name, fg, bg)
  fg = fg or colors.fg
  bg = bg or colors.bg

  cmd(string.format(
    'highlight StatusLine%s guifg=%s guibg=%s',
    name, fg, bg
  ))
end

local function get_highlight_component(name)
  return '%#StatusLine' .. name .. '#'
end

create_highlight('')

function GetStatusLine()
  local mode = fn.mode()

  create_highlight('Default')
  create_highlight('Mode', (mode_map[mode] or {color = colors.yellow}).color)
  create_highlight('Subtle', colors.subtle_fg)

  local extension = fn.expand('%:e')
  local filename = fn.expand('%:t')

  local mode_highlight = get_highlight_component('Mode')
  local default_highlight = get_highlight_component('Default')
  local subtle_highlight = get_highlight_component('Subtle')

  local mode_component = (mode_map[mode] or {label = mode}).label
  local fileicon_component = require'nvim-web-devicons'.get_icon(
    filename,
    extension,
    { default = false }
  ) or ''
  local filename_component = filename
  local modified_component = bo.modified and ' +' or ''
  local readonly_component = bo.readonly and ' ' or ''

  local filetype_component = bo.filetype
  local line_col_component = string.format(' %s:%s │ ', fn.line('.'), fn.col('.'))

  local function line_percent()
    local current_line = vim.fn.line('.')
    local total_lines = vim.fn.line('$')

    if current_line == 1 then return 'Top' end
    if current_line == total_lines then return 'Bot' end

    return math.floor(current_line / total_lines * 100) .. ''
  end

  local status_line_components = {
    default_highlight,

    mode_highlight,
    prefix_component,
    mode_component,
    spacer_component,

    default_highlight,
    fileicon_component,
    spacer_component,
    filename_component,
    modified_component,
    readonly_component,

    split_component,

    subtle_highlight,
    filetype_component,
    default_highlight,

    line_col_component,
    line_percent(),

    mode_highlight,
    suffix_component,
    default_highlight,
  }

  return table.concat(status_line_components, '')
end

return [[%!luaeval('GetStatusLine()')]]
