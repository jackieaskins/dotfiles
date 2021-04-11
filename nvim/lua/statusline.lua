local fn = vim.fn
local bo,o = vim.bo,vim.o

local colors = require'colors'
local modes = require'statusline/modes'
local highlights = require'statusline/highlights'

local M = {}

local prefix_component = '▊ '
local spacer_component = ' '
local split_component = '%='

local function get_file_icon_component(filename, extension)
  if filename == '' then return '' end

  return require'nvim-web-devicons'.get_icon(
    filename,
    extension,
    {default = false}
  ) or ''
end

local function get_buf_clients()
  local filetype = bo.filetype

  local function is_buf_client(client)
    local filetypes = client.config.filetypes or {}
    return fn.index(filetypes, filetype) ~= -1
  end

  return vim.tbl_filter(is_buf_client, vim.lsp.get_active_clients())
end

local function get_lsp_clients_component()
  local function get_name(client)
    return client.name
  end
  local client_names = vim.tbl_map(get_name, get_buf_clients())
  return table.concat(client_names, ' ')
end

local level_icons = {
  Hint = '',
  Information = '',
  Warning = '',
  Error = '',
}
local function get_lsp_diagnostic_component(level)
  if #get_buf_clients() == 0 then return '' end

  local count = vim.lsp.diagnostic.get_count(0, level)

  return level_icons[level] .. ' ' .. count .. ' '
end

function GetActiveLine()
  local default_highlight = highlights.define_active('')
  local mode_highlight = highlights.define_active('Mode', modes.get_color())
  local subtle_highlight = highlights.define_active('Subtle', colors.gray4)
  local info_highlight = highlights.define_active('Info', colors.cyan)
  local warn_highlight = highlights.define_active('Warn', colors.orange)
  local error_highlight = highlights.define_active('Error', colors.red)

  local extension = fn.expand('%:e')
  local filename = fn.expand('%:t')

  local mode_component = modes.get_label()
  local paste_component = o.paste and ' [PASTE]' or ''

  local filename_component = filename
  local modified_component = bo.modified and ' ' or ''
  local readonly_component = bo.readonly and ' ' or ''

  local filetype_component = bo.filetype
  local line_col_percent_component = ' %l:%c │ %p%%'

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
    spacer_component,

    split_component,

    default_highlight,
    get_lsp_diagnostic_component('Hint'),
    info_highlight,
    get_lsp_diagnostic_component('Information'),
    warn_highlight,
    get_lsp_diagnostic_component('Warning'),
    error_highlight,
    get_lsp_diagnostic_component('Error'),
    default_highlight,

    subtle_highlight,
    get_lsp_clients_component(),
    spacer_component,

    split_component,

    filetype_component,

    mode_highlight,
    line_col_percent_component,
  }

  return table.concat(status_line_components, '')
end

function GetInactiveLine()
  local default_highlight = highlights.define_inactive('')

  local filename_component = '%t'
  local line_col_percent_component = ' %l:%c │ %p%%'

  local components = {
    default_highlight,
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
