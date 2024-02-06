local highlight = require('utils').highlight
local modes = require('modes')

local modified_icon = ' '
local readonly_icon = ' '

local function active_clients()
  local all_names = {}
  local filetype = vim.bo.filetype

  local client_names = {}
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  for _, client in ipairs(vim.tbl_values(buf_clients)) do
    table.insert(client_names, require('lsp.utils').get_server_display_name(client.name))
  end
  if #client_names > 0 then
    table.insert(all_names, table.concat(client_names, ' '))
  end

  local linter_names = {}
  for _, linter in ipairs(require('lint').linters_by_ft[filetype] or {}) do
    table.insert(linter_names, linter)
  end
  if #linter_names > 0 then
    table.insert(all_names, table.concat(linter_names, ' '))
  end

  local formatter = require('plugins.conform').get_formatter_for_filetype(filetype)
  if formatter then
    table.insert(all_names, formatter.name)
  end

  return table.concat(all_names, '|')
end

local function statusline_component(hl, component, condition)
  local hl_str = '%#' .. hl .. '#'
  if condition ~= false and component and component ~= '' then
    return hl_str .. ' ' .. component .. ' '
  end

  return hl_str
end

local M = {}

function M.get_statusline()
  local colors = require('colors').get_colors()
  local mode_color = modes.get_color()

  highlight('StatusLineMode', { fg = colors.base, bg = mode_color, bold = true })
  highlight('StatusLineSection', { fg = mode_color, bg = colors.surface0 })

  local bufname = vim.api.nvim_buf_get_name(0)
  local filename = bufname and bufname ~= '' and vim.fn.fnamemodify(bufname, ':t') or '[No Name]'
  local filetype = vim.bo.filetype

  return table.concat({
    statusline_component('StatusLineMode', ' ' .. modes.get_label()),
    statusline_component('StatusLineSection', require('lazy.status').updates(), require('lazy.status').has_updates()),
    statusline_component(
      'StatusLine',
      table.concat({
        vim.bo.readonly and readonly_icon or '',
        filename,
        vim.bo.modified and modified_icon or '',
      })
    ),

    '%=',

    statusline_component(
      'StatusLine',
      table.concat({
        require('icons').get_filetype_icon(filetype),
        filetype,
      }, ' ')
    ),
    statusline_component('StatusLineSection', active_clients()),
    statusline_component('StatusLineMode', '%l:%c|%p%%'),
  })
end

return M
