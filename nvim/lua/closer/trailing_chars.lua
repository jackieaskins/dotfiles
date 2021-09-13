local trailing_chars_by_ft = {
  dart = {
    include_current = false,
    chars = {
      argument = ',',
      named_argument = ',',
      list_literal = ',',
      return_statement = ';',
      function_body = '',
      class_definition = '',
      if_statement = '',
      expression_statement = ';',
    },
  },
}

local M = {}

function M.get_trailing_chars()
  local ft_map = trailing_chars_by_ft[vim.bo.filetype]
  if not ft_map then
    return ''
  end

  local trailing_chars = ft_map.chars
  local include_current = ft_map.include_current

  local node = require('nvim-treesitter.ts_utils').get_node_at_cursor()
  if not node then
    return ''
  end

  if not include_current then
    node = node:parent()
  end
  while node do
    local trail = trailing_chars[node:type()]
    if trail then
      return trail
    end

    node = node:parent()
  end

  return ''
end

return M
