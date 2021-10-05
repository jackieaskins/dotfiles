local fn = vim.fn
local utils = require('utils')
local map, t = utils.map, utils.t

local function new_line()
  fn.feedkeys(t('<CR>'), 'n')
  return ''
end

local function is_comment_or_string(col)
  local row = fn.line('.') - 1
  local matches = require('nvim-treesitter.query').get_capture_matches(0, { '@comment', '@string' }, 'highlights')

  for _, match in ipairs(matches) do
    local node = match.node
    if node and require('nvim-treesitter.ts_utils').is_in_node_range(node, row, col) then
      return true
    end
  end

  return false
end

function _G.close()
  local tag_result = require('closer.tags').handle_tags()
  if tag_result ~= nil then
    return ''
  end

  if fn.col('.') < fn.col('$') then
    return new_line()
  end

  local open_to_close_map, close_to_opens_map, pattern = require('closer.pairs').get_filetype_opts()

  local stack = {}
  local start = 0
  local line = fn.getline('.')

  repeat
    local matched, match_start, match_end = unpack(fn.matchstrpos(line, pattern, start))
    start = match_end

    if is_comment_or_string(match_start) then
    elseif open_to_close_map[matched] then
      table.insert(stack, matched)
    elseif close_to_opens_map[matched] then
      local opens = close_to_opens_map[matched]

      local top = stack[#stack]
      if vim.tbl_contains(opens, top) then
        table.remove(stack, #stack)
      end
    end
  until start == -1

  if #stack == 0 then
    return new_line()
  end

  new_line()
  for i = 1, #stack do
    local open = stack[#stack + 1 - i]
    local close = open_to_close_map[open]

    fn.feedkeys(t(close))
    local trailing_chars = require('closer.trailing_chars').get_trailing_chars()
    fn.feedkeys(t(trailing_chars))
  end

  fn.feedkeys(t('<Esc>==O'))

  return ''
end

map('i', '<CR>', 'v:lua.close()', { expr = true, silent = true })
