local fn = vim.fn
local bo,o = vim.bo,vim.o

local colors = require'statusline/colors'
local modes = require'statusline/modes'
local highlights = require'statusline/highlights'

local M = {}

local prefix_component = '▊ '
local spacer_component = ' '
local split_component = '%='

local function get_line_percent_component()
  local current_line = vim.fn.line('.')
  local total_lines = vim.fn.line('$')

  if current_line == 1 then return 'Top' end
  if current_line == total_lines then return 'Bot' end

  return math.floor(current_line / total_lines * 100) .. ''
end

local function get_file_icon_component(filename, extension)
  if filename == '' then return '' end

  return require'nvim-web-devicons'.get_icon(
    filename,
    extension,
    {default = false}
  ) or ''
end

function GetActiveLine()
  local default_highlight = highlights.define_active('')
  local mode_highlight = highlights.define_active('Mode', modes.get_color())
  local subtle_highlight = highlights.define_active('Subtle', colors.subtle_fg)

  local extension = fn.expand('%:e')
  local filename = fn.expand('%:t')

  local mode_component = modes.get_label()
  local paste_component = o.paste and ' [PASTE]' or ''

  local filename_component = filename
  local modified_component = bo.modified and ' +' or ''
  local readonly_component = bo.readonly and ' ' or ''

  local filetype_component = bo.filetype
  local line_col_component = string.format(' %s:%s │ ', fn.line('.'), fn.col('.'))

  local status_line_components = {
    default_highlight,

    mode_highlight,
    prefix_component,
    mode_component,
    paste_component,
    spacer_component,

    default_highlight,
    get_file_icon_component(filename, extension),
    spacer_component,
    filename_component,
    modified_component,
    readonly_component,

    split_component, -- Starts right portion of status line

    mode_highlight,
    filetype_component,
    default_highlight,

    subtle_highlight,
    line_col_component,
    get_line_percent_component(),
  }

  return table.concat(status_line_components, '')
end

function GetInactiveLine()
  local default_highlight = highlights.define_inactive('')

  local filename_component = '%t'

  local components = {
    default_highlight,
    prefix_component,
    filename_component,

    split_component,
  }

  return table.concat(components, '')
end

function M.get_active()
  vim.wo.statusline = '%!luaeval("GetActiveLine()")'
end

function M.get_inactive()
  vim.wo.statusline = '%!luaeval("GetInactiveLine()")'
end

return M
