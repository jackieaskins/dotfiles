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

local function get_active_lsp_linters_formatters()
  local function get_lsp_clients()
    return vim.tbl_map(function(client)
      return require('lsp.utils').get_server_display_name(client.name)
    end, vim.lsp.get_clients({ bufnr = 0 }))
  end

  local function get_linters()
    return require('lint').linters_by_ft[vim.bo.filetype] or {}
  end

  local function get_formatters()
    local formatters, use_lsp = require('conform').list_formatters_to_run()
    local formatter_names = vim.tbl_map(function(formatter)
      return formatter.name
    end, formatters)
    if use_lsp then
      table.insert(formatter_names, 'lsp_format')
    end
    return formatter_names
  end

  local all_client_names = {}
  for _, fn in ipairs({ get_lsp_clients, get_linters, get_formatters }) do
    local ok, clients = pcall(fn)
    if ok and #clients > 0 then
      table.insert(all_client_names, table.concat(clients, ' '))
    end
  end

  return #all_client_names > 0 and '󰣖 ' .. table.concat(all_client_names, '|') or ''
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
      statusline_component('StatusLineSection', get_active_lsp_linters_formatters()),
      statusline_component('StatusLineMode', '%l:%c|%p%%'),
    })
  end,
}
