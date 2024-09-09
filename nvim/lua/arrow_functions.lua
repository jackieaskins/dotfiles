---Replace node text with provided text
---@param node TSNode
---@param lines string[]
local function replace_node_text(node, lines)
  local sr, sc, er, ec = node:range()
  vim.api.nvim_buf_set_text(0, sr, sc, er, ec, lines)
end

---Search up from node to find arrow function node
---@param node TSNode | nil
---@return TSNode | nil
local function find_arrow_function_node(node)
  if node == nil then
    return nil
  end

  if node:type() == 'arrow_function' then
    return node
  end

  return find_arrow_function_node(node:parent())
end

---Remove braces from arrow function
---@param body_node TSNode
local function remove_braces(body_node)
  local body_children = body_node:named_children()
  if #body_children > 1 then
    vim.notify('Cannot remove braces from an arrow function with multiple children')
    return
  end

  local content_node = body_children[1]
  local new_text

  if content_node:type() == 'return_statement' then
    local returned_node = content_node:named_children()[1]
    local text = vim.treesitter.get_node_text(returned_node, 0)
    new_text = returned_node:type() == 'object' and '(' .. text .. ')' or text
  else
    new_text = vim.treesitter.get_node_text(content_node, 0):gsub(';$', '')
  end

  replace_node_text(body_node, vim.split(new_text, '\n' .. (' '):rep(vim.bo.shiftwidth)))
end

---Add braces to arrow function
---@param body_node TSNode
---@param body_text string
local function add_braces(body_node, body_text)
  local current_line = vim.api.nvim_get_current_line()
  local _, space_count = current_line:find('^%s*')

  local returned_text = (' '):rep(space_count or 0) .. 'return ' .. body_text
  local unindented_lines = vim.split(returned_text, '\n')

  local lines = vim.tbl_map(function(line)
    return (' '):rep(vim.bo.shiftwidth) .. line
  end, unindented_lines)
  table.insert(lines, 1, '{')
  table.insert(lines, '}')

  replace_node_text(body_node, lines)
end

local M = {}

function M.toggle_braces()
  local current_node = vim.treesitter.get_node({ ignore_injections = false })
  local arrow_function_node = find_arrow_function_node(current_node)
  if not arrow_function_node then
    vim.notify('Not currently on an arrow function')
    return
  end

  local body_nodes = arrow_function_node:field('body')
  if arrow_function_node:has_error() or #body_nodes ~= 1 then
    vim.notify('Invalid arrow function')
    return
  end

  local body_node = body_nodes[1]
  local body_text = vim.treesitter.get_node_text(body_node, 0)

  if body_text:match('^{.*}$') then
    remove_braces(body_node)
  else
    add_braces(body_node, body_text)
  end
end

return M
