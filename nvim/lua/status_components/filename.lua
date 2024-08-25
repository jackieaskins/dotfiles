local modified_icon = ' '
local readonly_icon = ' '

local filetype_displays = {
  fugitiveblame = '[Git Blame]',
  NvimTree = '[NvimTree]',
  checkhealth = '[Health Check]',
}

local M = {}

function M.get_filename(filename, bufnr, quickfix_title, modify_filename)
  local filetype = vim.fn.getbufvar(bufnr, '&filetype')

  if filetype == 'qf' then
    local suffix = quickfix_title and quickfix_title ~= '' and ' ' .. quickfix_title or ''
    return '[Quickfix]' .. suffix
  end

  local filetype_display = filetype_displays[filetype]
  if filetype_display then
    return filetype_display
  end

  if filename == '' then
    return '[No Name]'
  end

  return modify_filename(filename)
end

function M.get_filename_display(filename, bufnr, quickfix_title, modify_filename)
  local fname = M.get_filename(filename, bufnr, quickfix_title, modify_filename)
  local modified = vim.fn.getbufvar(bufnr, '&mod') == 1

  return table.concat({
    vim.fn.getbufvar(bufnr, '&readonly') == 1 and readonly_icon or '',
    fname,
    modified and modified_icon or '',
  })
end

return M
