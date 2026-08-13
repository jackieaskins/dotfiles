require('utils').augroup('winbar_redraw', {
  { 'DiagnosticChanged', command = 'redrawstatus' },
})

local function get_hl(hl)
  return '%#' .. hl .. '#'
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

return {
  get_winbar = function()
    local filetype = vim.bo.filetype

    if filetype == 'snacks_dashboard' then
      return ''
    end

    return table.concat({
      get_hl('WinBarFile'),
      require('icons').get_filetype_icon(filetype),
      get_filename_display(),

      '%=',

      vim.diagnostic.status() .. ' ',
    }, ' ')
  end,
}
