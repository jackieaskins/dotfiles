require('utils').augroup('statusline_redraw', {
  { 'User', pattern = 'LazyCheck', command = 'redrawstatus' },
})

local function statusline_component(hl, component)
  local hl_str = '%#' .. hl .. '#'
  if component and component ~= '' then
    return hl_str .. ' ' .. component .. ' '
  end

  return hl_str
end

local function get_active_clients()
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
  local lint_ok, lint_plugin = pcall(require, 'plugins.lint')
  if lint_ok then
    for _, linter in ipairs(lint_plugin.get_linters_for_filetype(filetype)) do
      table.insert(linter_names, linter)
    end
    if #linter_names > 0 then
      table.insert(all_names, table.concat(linter_names, ' '))
    end
  end

  local format_ok, format_plugin = pcall(require, 'plugins.conform')
  if format_ok then
    local formatter = format_plugin.get_formatter_for_filetype(filetype)
    if formatter then
      table.insert(all_names, formatter.name)
    end
  end

  local client_str = table.concat(all_names, '|')

  return #client_str > 0 and '󰣖 ' .. client_str or ''
end

local function get_filename()
  return require('status_components.filename').get_filename_display(
    vim.api.nvim_buf_get_name(0),
    vim.fn.bufnr(),
    vim.w.quickfix_title,
    function(filename)
      return vim.fn.fnamemodify(filename, ':t')
    end
  )
end

local function get_lazy_updates()
  local ok, status = pcall(require, 'lazy.status')
  return ok and status.updates() or ''
end

return {
  get_statusline = function()
    local modes = require('modes')

    local filetype = vim.bo.filetype

    return table.concat({
      statusline_component('StatusLineMode', ' ' .. modes.get_label()),
      statusline_component('StatusLineSection', get_lazy_updates()),
      statusline_component('StatusLine', get_filename()),

      '%=',

      statusline_component(
        'StatusLine',
        table.concat({
          filetype == '' and '' or require('icons').get_filetype_icon(filetype),
          filetype,
        }, ' ')
      ),
      statusline_component('StatusLineSection', get_active_clients()),
      statusline_component('StatusLineMode', '%l:%c|%p%%'),
    })
  end,
}
