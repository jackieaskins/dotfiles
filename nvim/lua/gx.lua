local function matchstrpos_cursor(pattern)
  ---@diagnostic disable-next-line: param-type-mismatch
  local line = vim.fn.getline('.')
  local col = vim.fn.col('.') - 1

  local count = 1

  while true do
    local result = vim.fn.matchstrpos(line, pattern, 0, count)

    if vim.tbl_isempty(result) or result[2] == -1 or result[3] == -1 then
      return nil
    end

    local start, end_ = result[2], result[3]
    if col >= start and col <= end_ then
      return vim.fn.matchlist(line, pattern, 0, count)
    end

    count = count + 1
  end
end

local M = {}

M.handle_url_under_cursor = function()
  local supported_matchers = vim.tbl_filter(function(matcher)
    return vim.fn.match(vim.fn.bufname(), matcher.file_pattern) ~= -1
  end, require('gx.matchers'))

  for _, matcher in ipairs(supported_matchers) do
    local match = matchstrpos_cursor(matcher.pattern)
    if match then
      local url = matcher.handler(match)
      if url then
        return require('utils').open_url(url)
      end
    end
  end
end

return M
