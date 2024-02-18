local highlight = require('utils').highlight

local modified_icon = ' '
local readonly_icon = ' '

local function get_hl(hl)
  local is_active = tostring(vim.g.actual_curwin) == tostring(vim.api.nvim_get_current_win())
  return '%#' .. (is_active and hl or 'WinBarInactive') .. '#'
end

local M = {}

require('utils').augroup('winbar', {
  { 'DiagnosticChanged', command = 'redrawstatus' },
})

local function get_filename_display()
  local filetype = vim.bo.filetype

  if filetype == 'qf' then
    local quickfix_title = vim.w.quickfix_title
    local suffix = quickfix_title and ' ' .. quickfix_title or ''
    return '[Quickfix]' .. suffix
  end

  local bufname = vim.api.nvim_buf_get_name(0)

  if not bufname or bufname == '' then
    return '[No Name]'
  end

  local filename = filetype == 'help' and 'doc/' .. vim.fn.fnamemodify(bufname, ':t') or bufname
  local head = vim.fn.fnamemodify(filename, ':~:.:h'):gsub('\\', '/')
  local parts = head == '.' and {} or vim.split(head, '/')
  local tail = table.concat({
    vim.bo.readonly and readonly_icon or '',
    vim.fn.fnamemodify(filename, ':t'),
    vim.bo.modified and modified_icon or '',
  })
  table.insert(parts, tail)

  return table.concat(parts, ' ')
end

local function get_diagnostic(hl, counts, severity)
  local count = counts[severity]

  if not count or count <= 0 then
    return ''
  end

  return table.concat({
    get_hl(hl),
    require('diagnostic.icons')[severity],
    count,
    ' ',
  })
end

function M.get_winbar()
  local colors = require('colors').get_colors()
  local mode_color = require('modes').get_color()

  highlight('WinBarInactive', { fg = colors.overlay1, bg = colors.base })
  highlight('WinBarFile', { fg = mode_color, bg = colors.base })

  local diagnostic_counts = vim.diagnostic.count(0)

  return table.concat({
    get_hl('WinBarFile'),
    ' ',
    require('icons').get_filetype_icon(vim.bo.filetype),
    ' ',
    get_filename_display(),
    ' ',

    '%=',

    vim.tbl_isempty(diagnostic_counts) and '' or ' ',
    get_diagnostic('WinBarDiagnosticError', diagnostic_counts, vim.diagnostic.severity.ERROR),
    get_diagnostic('WinBarDiagnosticWarn', diagnostic_counts, vim.diagnostic.severity.WARN),
    get_diagnostic('WinBarDiagnosticInfo', diagnostic_counts, vim.diagnostic.severity.INFO),
    get_diagnostic('WinBarDiagnosticHint', diagnostic_counts, vim.diagnostic.severity.HINT),
  })
end

return M
