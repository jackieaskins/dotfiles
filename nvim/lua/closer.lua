local fn = vim.fn
local utils = require('utils')
local map = utils.map

local function at_eol()
  return fn.col('.') >= fn.col('$')
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

local function get_opens_on_curr_line()
  local open_to_close_map, close_to_opens_map, pattern = require('closer.pairs').get_filetype_opts()
  local line = fn.getline('.')

  local stack = {}
  local start = 0

  repeat
    local matched, match_start, match_end = unpack(fn.matchstrpos(line, pattern, start))

    if matched:match('^%w+$') ~= nil then
      if match_start ~= 0 and line:sub(match_start, match_start):match('%w') ~= nil then
        matched = nil
      end

      if match_end + 1 ~= #line and line:sub(match_end + 1, match_end + 1):match('%w') ~= nil then
        matched = nil
      end
    end
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

  return stack
end

local function is_followed_by_close(rest_of_line, close_to_opens_map)
  local first_word = rest_of_line:match('(%w+)(%W+)') or ''
  local next_char = vim.trim(rest_of_line):sub(1, 1) or ''

  local checks = { rest_of_line, first_word, next_char }

  for close, _ in pairs(close_to_opens_map) do
    if vim.tbl_contains(checks, close) then
      return true
    end
  end

  return false
end

local function handle_close()
  local keys = { '<c-g>u<CR>' }

  local open_to_close_map, close_to_opens_map = require('closer.pairs').get_filetype_opts()
  local line = fn.getline('.')

  local tag_key = require('closer.tags').handle_tags()

  if tag_key ~= nil then
    table.insert(keys, tag_key)
  elseif at_eol() then
    local opens = get_opens_on_curr_line()
    for i = 1, #opens do
      local open = opens[#opens + 1 - i]
      local close = open_to_close_map[open]
      table.insert(keys, close)
    end

    if #opens > 0 then
      table.insert(keys, '<Esc>==O')
    end
  else
    local rest_of_line = string.sub(line, fn.col('.'))
    if is_followed_by_close(rest_of_line, close_to_opens_map) then
      table.insert(keys, '<Esc>==O')
    end
  end

  table.insert(keys, '<c-g>u')
  return table.concat(keys, '')
end

map('i', '<CR>', handle_close, { desc = 'Close any open pairs', expr = true })
