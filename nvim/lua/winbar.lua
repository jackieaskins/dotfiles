local utils = require('utils')
local augroup, highlight = utils.augroup, utils.highlight

augroup('winbar_redraw', {
  { 'DiagnosticChanged', command = 'redrawstatus' },
})

local function get_hl(hl)
  local is_active = tostring(vim.g.actual_curwin) == tostring(vim.api.nvim_get_current_win())
  return '%#' .. (is_active and hl or 'WinBarInactive') .. '#'
end

local function get_filename_display()
  return require('status_components.filename').get_filename_display(
    vim.api.nvim_buf_get_name(0),
    vim.fn.bufnr(),
    vim.w.quickfix_title,
    function(bufname)
      local filetype = vim.bo.filetype
      local filename = filetype == 'help' and 'doc/' .. vim.fn.fnamemodify(bufname, ':t') or bufname
      local head = vim.fn.fnamemodify(filename, ':~:.:h'):gsub('\\', '/')

      local parts = head == '.' and {} or vim.split(head, '/')
      table.insert(parts, vim.fn.fnamemodify(filename, ':t'))

      return table.concat(parts, ' ')
    end
  )
end

local function get_diagnostic(hl, counts, severity)
  local sev = vim.diagnostic.severity[severity]
  local count = counts[sev]

  if not count or count <= 0 then
    return ''
  end

  return table.concat({
    get_hl(hl),
    require('diagnostic.icons')[sev],
    count,
    ' ',
  })
end

return {
  get_winbar = function()
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
      get_diagnostic('WinBarDiagnosticError', diagnostic_counts, 'ERROR'),
      get_diagnostic('WinBarDiagnosticWarn', diagnostic_counts, 'WARN'),
      get_diagnostic('WinBarDiagnosticInfo', diagnostic_counts, 'INFO'),
      get_diagnostic('WinBarDiagnosticHint', diagnostic_counts, 'HINT'),
    })
  end,
}
