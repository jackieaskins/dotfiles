local fn = vim.fn
local utils = require('utils')
local map, t = utils.map, utils.t

local function ts_utils()
  return require('nvim-treesitter.ts_utils')
end

-- TODO: Allow snippet-like jumping between brackets
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

local tags = {
  jsx_closing_element = 'jsx_opening_element',
  end_tag = 'start_tag',
}

local function fallback()
  return t('<CR>')
end

local function check_for_tags(current_node)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local start_row, start_col = current_node:start()
  local open_tag = tags[current_node:type()]

  if open_tag ~= nil then
    local previous_node = ts_utils().get_previous_node(current_node)
    if previous_node:type() == open_tag and start_row == cursor[1] - 1 and start_col == cursor[2] then
      return t('<CR><Esc>O')
    end
    return fallback()
  end

  return nil
end

local function check_for_fragment(current_node)
  local start_row, start_col = current_node:start()
  local end_row = current_node:end_()

  if current_node:type() == 'jsx_fragment' and start_row == end_row and fn.col('.') == start_col + 3 then
    return t('<CR><Esc>O')
  end

  return nil
end

-- TODO: Make this work for multi-line comments
local function is_comment_or_string(col)
  local row = fn.line('.') - 1
  local matches = require('nvim-treesitter.query').get_capture_matches(0, { '@comment', '@string' }, 'highlights')

  for _, match in ipairs(matches) do
    local node = match.node
    if node and ts_utils().is_in_node_range(node, row, col) then
      return true
    end
  end

  return false
end

function _G.close()
  local current_node = ts_utils().get_node_at_cursor()

  if current_node ~= nil then
    local tags_result = check_for_tags(current_node)
    if tags_result ~= nil then
      return tags_result
    end

    local fragment_result = check_for_fragment(current_node)
    if fragment_result ~= nil then
      return fragment_result
    end
  end

  local open_pairs = pairs_by_language[vim.bo.filetype] or standard

  local close_pairs = {}
  for open, close in pairs(open_pairs) do
    local opens = close_pairs[close] or {}
    table.insert(opens, open)
    close_pairs[close] = opens
  end

  local all_delims = vim.tbl_keys(open_pairs)
  vim.list_extend(all_delims, vim.tbl_keys(close_pairs))
  local pattern = '\\V\\(' .. table.concat(all_delims, '\\|') .. '\\)'
  local stack = {}

  local start = 0

  -- TODO: Ideally check for matching brackets instead
  if fn.col('.') <= fn.col('$') - 1 then
    return fallback()
  end

  local line = fn.getline('.')

  repeat
    local matched, match_start, match_end = unpack(fn.matchstrpos(line, pattern, start))
    start = match_end

    if is_comment_or_string(match_start) then
    elseif open_pairs[matched] then
      table.insert(stack, matched)
    elseif close_pairs[matched] then
      local opens = close_pairs[matched]
      local removed = table.remove(stack, #stack)

      if not vim.tbl_contains(opens, removed) then
        return fallback()
      end
    end
  until start == -1

  if #stack == 0 then
    return fallback()
  end

  local ends = {}
  for _, open in ipairs(stack) do
    table.insert(ends, 1, open_pairs[open])
  end

  return t('<CR><CR>' .. table.concat(ends, '') .. '<Esc>==kcc')
end

map('i', '<CR>', 'v:lua.close()', { expr = true, silent = true })
