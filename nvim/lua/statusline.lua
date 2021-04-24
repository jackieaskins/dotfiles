local fn = vim.fn
local bo,o = vim.bo,vim.o

local colors = require'colors'
local modes = require'statusline/modes'
local highlights = require'statusline/highlights'
local lsp_icons = require'lsp/icons'

local M = {}

local prefix_component = '▊ '
local spacer_component = ' '
local split_component = '%='

local function get_file_icon_component(filename, extension)
  if filename == '' then return '' end
  local icon = require'nvim-web-devicons'.get_icon(
    filename,
    extension,
    {default = false}
  )

  return icon and icon .. ' ' or ''
end

local function get_buf_clients()
  return vim.tbl_values(vim.lsp.buf_get_clients(fn.bufnr('%')))
end

local function get_lsp_clients_component()
  local function get_name(client)
    return client.name
  end
  local client_names = vim.tbl_map(get_name, get_buf_clients())
  return table.concat(client_names, ' ')
end

local function get_lsp_diagnostic_component(level)
  if #get_buf_clients() == 0 then return '' end

  local count = vim.lsp.diagnostic.get_count(0, level)

  return lsp_icons[level] .. ' ' .. count .. ' '
end

local active_highlight = highlights.define_active('')
local subtle_highlight = highlights.define_active('Subtle', colors.comment_gray)
local hint_highlight = highlights.define_active('Hint', colors.cyan)
local info_highlight = highlights.define_active('Info', colors.blue)
local warn_highlight = highlights.define_active('Warn', colors.yellow)
local error_highlight = highlights.define_active('Error', colors.red)
function GetActiveLine()
  local mode_highlight = highlights.define_active('Mode', modes.get_color())

  local extension = fn.expand('%:e')
  local filename = fn.expand('%:t')

  local mode_component = modes.get_label()
  local paste_component = o.paste and ' [PASTE]' or ''

  local filename_component = filename
  local modified_component = bo.modified and ' ' or ''
  local readonly_component = bo.readonly and ' ' or ''

  local filetype_component = bo.filetype
  local line_col_percent_component = ' %l:%c │ %p%%'

  local function render_based_on_width(component, max_width)
    local window_width = fn.winwidth('%')
    max_width = max_width or 80

    return window_width > max_width and component or ''
  end

  local status_line_components = {
    active_highlight,

    mode_highlight,
    prefix_component,
    mode_component,
    paste_component,
    spacer_component,

    active_highlight,
    get_file_icon_component(filename, extension),
    filename_component,
    modified_component,
    readonly_component,
    spacer_component,

    split_component,

    hint_highlight,
    get_lsp_diagnostic_component('Hint'),
    info_highlight,
    get_lsp_diagnostic_component('Information'),
    warn_highlight,
    get_lsp_diagnostic_component('Warning'),
    error_highlight,
    get_lsp_diagnostic_component('Error'),
    active_highlight,

    render_based_on_width(subtle_highlight),
    render_based_on_width(get_lsp_clients_component()),
    render_based_on_width(spacer_component),
    render_based_on_width(active_highlight),

    split_component,

    subtle_highlight,
    filetype_component,
    active_highlight,

    mode_highlight,
    line_col_percent_component,
    active_highlight,
  }

  return table.concat(status_line_components, '')
end

local inactive_highlight = highlights.define_inactive('')
function GetInactiveLine()
  local filename_component = '%t'
  local line_col_percent_component = ' %l:%c │ %p%%'

  local components = {
    inactive_highlight,
    prefix_component,
    filename_component,

    split_component,

    line_col_percent_component,
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
