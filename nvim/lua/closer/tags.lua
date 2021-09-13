local fn = vim.fn
local ts_utils = require('nvim-treesitter.ts_utils')
local t = require('utils').t

local tags = {
  jsx_closing_element = 'jsx_opening_element',
  end_tag = 'start_tag',
}

local function new_line()
  fn.feedkeys(t('<CR><Esc>==O'), 'n')
  return ''
end

local function check_for_tags(current_node)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local start_row, start_col = current_node:start()
  local open_tag = tags[current_node:type()]

  if open_tag ~= nil then
    local previous_node = ts_utils.get_previous_node(current_node)
    if previous_node:type() == open_tag and start_row == cursor[1] - 1 and start_col == cursor[2] then
      return new_line()
    end
    fn.feedkeys(t('<CR>'), 'n')
    return ''
  end

  return nil
end

local function check_for_fragment(current_node)
  local start_row, start_col = current_node:start()
  local end_row = current_node:end_()

  if current_node:type() == 'jsx_fragment' and start_row == end_row and fn.col('.') == start_col + 3 then
    return new_line()
  end

  return nil
end

local M = {}

function M.handle_tags()
  local current_node = ts_utils.get_node_at_cursor()

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
end

return M
