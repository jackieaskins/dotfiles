local standard = {
  ['{'] = '}',
  ['('] = ')',
  ['['] = ']',
}

local pairs_by_language = {
  lua = {
    ['function'] = 'end',
    ['do'] = 'end',
    ['then'] = 'end',
    ['repeat'] = 'until',
    ['{'] = '}',
    ['('] = ')',
    ['['] = ']',
  },
}

local M = {}

function M.get_filetype_opts()
  local open_to_close_map = pairs_by_language[vim.bo.filetype] or standard

  local close_to_opens_map = {}
  for open, close in pairs(open_to_close_map) do
    local opens = close_to_opens_map[close] or {}
    table.insert(opens, open)
    close_to_opens_map[close] = opens
  end

  local all_delims = vim.tbl_keys(open_to_close_map)
  vim.list_extend(all_delims, vim.tbl_keys(close_to_opens_map))
  local pattern = '\\V\\(' .. table.concat(all_delims, '\\|') .. '\\)'

  return open_to_close_map, close_to_opens_map, pattern
end

return M
