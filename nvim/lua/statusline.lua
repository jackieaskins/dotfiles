require('utils').augroup('statusline_redraw', {
  { 'User', pattern = 'LazyCheck', command = 'redrawstatus' },
})

local function get_hl_str(hl)
  return '%#' .. hl .. '#'
end

local function statusline_component(hl, component, seps)
  seps = seps or {}
  local parts = {}
  local has_component = component and component ~= ''

  local component_hl = get_hl_str(hl)
  local sep_hl = get_hl_str(hl .. 'Sep')

  if has_component and seps.left then
    table.insert(parts, sep_hl)
    table.insert(parts, seps.left)
  end

  table.insert(parts, component_hl)

  if has_component then
    table.insert(parts, ' ')
    table.insert(parts, component)
    table.insert(parts, ' ')
  end

  if has_component and seps.right then
    table.insert(parts, sep_hl)
    table.insert(parts, seps.right)
  end

  return table.concat(parts)
end

local function get_active_lsps_and_formatters()
  local function get_lsp_clients()
    return vim.tbl_map(function(client)
      return require('lsp.utils').get_server_display_name(client.name)
    end, vim.lsp.get_clients({ bufnr = 0 }))
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
  for _, fn in ipairs({ get_lsp_clients, get_formatters }) do
    local ok, clients = pcall(fn)
    if ok and #clients > 0 then
      table.insert(all_client_names, table.concat(clients, ' '))
    end
  end

  return #all_client_names > 0 and '󰣖 ' .. table.concat(all_client_names, '󰿟') or ''
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
      statusline_component('StatusLineMode', ' ' .. modes.get_label(), { right = '' }),
      statusline_component('StatusLineSection', get_lazy_updates(), { left = '', right = '' }),
      statusline_component('StatusLine', get_filename()),

      '%=',

      statusline_component(
        'StatusLine',
        table.concat({
          filetype == '' and '' or require('icons').get_filetype_icon(filetype),
          filetype,
        }, ' ')
      ),
      statusline_component('StatusLineSection', get_active_lsps_and_formatters(), { left = '', right = '' }),
      statusline_component('StatusLineMode', '%l:%c󰿟%p%%', { left = '' }),
    })
  end,
}
