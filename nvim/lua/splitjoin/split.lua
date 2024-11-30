---Returns a string with the number of spaces specified
---@param num_spaces integer
---@return string
local function get_indent(num_spaces)
  return (' '):rep(num_spaces)
end

---Handles iterating through node children using a provided split function
---Returns false if the node is not on a single line, otherwise returns true
---@param node TSNode
---@param split_fn fun(index: integer, num_children: integer, child_text: string, first_line_spaces: integer): string?
---@return boolean
local function split_node_wrapper(node, split_fn)
  local sr, sc, er, ec = node:range(false)

  if sr ~= er then
    return false
  end

  local current_line = vim.api.nvim_get_current_line()
  local _, num_spaces = current_line:find('^%s*')

  local lines = {}
  local num_children = node:child_count()
  for i = 0, num_children - 1 do
    local child = node:child(i)

    if not child then
      vim.notify('Invalid node')
      return true
    end

    local child_text = vim.treesitter.get_node_text(child, 0)
    local line = split_fn(i, num_children, child_text, num_spaces or 0)
    if line then
      lines[#lines + 1] = line
    end
  end

  vim.api.nvim_buf_set_text(0, sr, sc, er, ec, lines)
  return true
end

---Handles splitting an opening or self-closing tag
---@param node TSNode
local function split_node(node)
  local function split_fn(index, num_children, child_text, first_line_spaces)
    -- The 0th child is '<', so we ignore it and just prepend it to the tag name
    if index == 1 then
      return '<' .. child_text
    elseif index == num_children - 1 then
      return get_indent(first_line_spaces) .. child_text
    elseif index ~= 0 then
      return get_indent(first_line_spaces + vim.bo.tabstop) .. child_text
    end
  end

  split_node_wrapper(node, split_fn)
end

---Handles splitting an element with opening & closing tag
---@param node TSNode
---@return boolean
local function split_parent_node(node)
  local parent = node:parent()

  if not parent then
    vim.notify('Invalid node')
    return true
  end

  local function split_fn(index, num_children, child_text, first_line_spaces)
    local indent_count = (index == 0 and 0)
      or (index == num_children - 1 and first_line_spaces)
      or first_line_spaces + vim.bo.tabstop
    return get_indent(indent_count) .. child_text
  end

  return split_node_wrapper(parent, split_fn)
end

---@param node TSNode
local function split_end_tag(node)
  if not split_parent_node(node) then
    vim.notify('Nothing to split')
  end
end

---@param node TSNode
local function split_self_closing_tag(node)
  split_node(node)
end

---@param node TSNode
local function split_start_tag(node)
  if not split_parent_node(node) then
    split_node(node)
  end
end

local node_handlers = {
  jsx_closing_element = split_end_tag,
  end_tag = split_end_tag,
  jsx_self_closing_element = split_self_closing_tag,
  self_closing_tag = split_self_closing_tag,
  jsx_opening_element = split_start_tag,
  start_tag = split_start_tag,
}
local supported_node_types = vim.tbl_keys(node_handlers)
local unsupported_node_types = { 'jsx_expression' }
local find_supported_node = require('splitjoin.utils').find_supported_node(supported_node_types, unsupported_node_types)

return {
  split = function()
    local node = vim.treesitter.get_node({ ignore_injections = false })
    local supported_node = find_supported_node(node)

    if not supported_node then
      require('mini.splitjoin').split()
      return
    end

    if supported_node:has_error() then
      vim.notify("Can't split node with error")
      return
    end

    node_handlers[supported_node:type()](supported_node)
  end,
}

-- vim:foldlevel=0
