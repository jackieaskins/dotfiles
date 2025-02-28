local function get_bufnr(tabnr)
  local winnr = vim.fn.tabpagewinnr(tabnr)
  local buflist = vim.fn.tabpagebuflist(tabnr)
  return buflist[winnr]
end

return {
  get_tabline = function()
    local num_tabs = vim.fn.tabpagenr('$')
    local current_tabnr = vim.fn.tabpagenr()
    local tabline_components = {}

    local filenames = {}

    for tabnr = 1, num_tabs do
      local bufnr = get_bufnr(tabnr)
      local bufname = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':t')

      if bufname ~= '' then
        local count = filenames[bufname] or 0
        filenames[bufname] = count + 1
      end
    end

    for tabnr = 1, num_tabs do
      local bufnr = get_bufnr(tabnr)

      local function get_bufname()
        return require('status_components.filename').get_filename_display(
          vim.fn.bufname(bufnr),
          bufnr,
          vim.fn.gettabwinvar(tabnr, vim.fn.tabpagewinnr(tabnr) or 0, 'quickfix_title'),
          function(filename)
            local tail = vim.fn.fnamemodify(filename, ':t')
            if filenames[tail] == 1 then
              return tail
            end
            return vim.fn.pathshorten(vim.fn.fnamemodify(filename, ':~:.'))
          end
        )
      end

      local hl_group = tabnr == current_tabnr and 'TabLineSel' or 'TabLine'

      table.insert(
        tabline_components,
        table.concat({
          '%#' .. hl_group .. '#',
          ' ',
          tabnr,
          ' ',
          require('icons').get_filetype_icon(vim.api.nvim_get_option_value('filetype', {
            buf = bufnr,
          })),
          ' ',
          get_bufname(),
          ' ',
        })
      )
    end

    table.insert(tabline_components, '%#TabLineFill#')

    return table.concat(tabline_components)
  end,
}
