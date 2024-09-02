---Handles joining an opening or self-closing tag
---@param node TSNode
---@return boolean
local function join_node(node)
  local sr, sc, er, ec = node:range()

  if sr == er then
    return false
  end

  local joined_text = vim
    .treesitter
    .get_node_text(node, 0)
    :gsub('[\n\r]%s*<', '<') -- Remove newline and indent when line starts with <
    :gsub('[\n\r]%s*>', '>') -- Remove newline and indent when line starts with >
    :gsub('[\n\r]%s*', ' ') -- Replace any other newline and indent with a single space
  vim.api.nvim_buf_set_text(0, sr, sc, er, ec, { joined_text })

  return true
end

---Handles joining an element with open and closing tags
---@param node TSNode
local function join_parent_node(node)
  local parent = node:parent()

  if not parent then
    vim.notify('Invalid node')
  elseif not join_node(parent) then
    vim.notify('Nothing to join')
  end
end

---@param node TSNode
local function join_start_tag(node)
  if not join_node(node) then
    join_parent_node(node)
  end
end

---@param node TSNode
local function join_end_tag(node)
  join_parent_node(node)
end

---@param node TSNode
local function join_self_closing_tag(node)
  if not join_node(node) then
    vim.notify('Nothing to join')
  end
end

local node_handlers = {
  jsx_opening_element = join_start_tag,
  start_tag = join_start_tag,
  jsx_closing_element = join_end_tag,
  end_tag = join_end_tag,
  jsx_self_closing_element = join_self_closing_tag,
  self_closing_tag = join_self_closing_tag,
}
local supported_node_types = vim.tbl_keys(node_handlers)
local unsupported_node_types = { 'jsx_expression' }
local find_supported_node = require('splitjoin.utils').find_supported_node(supported_node_types, unsupported_node_types)

return {
  join = function()
    local node = vim.treesitter.get_node({ ignore_injections = false })
    local supported_node = find_supported_node(node)

    if not supported_node then
      require('mini.splitjoin').join()
      return
    end

    if supported_node:has_error() then
      vim.notify("Can't join node with error")
      return
    end

    node_handlers[supported_node:type()](supported_node)
  end,
}
