local ts_utils = require('treesitter.utils')

---@param template_substitution_node TSNode
local function remove_string_interpolation(template_substitution_node)
  local template_string_node = ts_utils.find_node_parent(template_substitution_node, 'template_string')

  if not template_string_node then
    return
  end

  local text = vim.treesitter.get_node_text(template_substitution_node, 0):gsub('%${', ''):gsub('}', '')

  ts_utils.replace_node_text(template_string_node, { text })
end

---@param current_node TSNode
local function add_string_interpolation(current_node)
  local supported_node = ts_utils.find_node_parent(current_node, { 'call_expression', 'identifier' })

  if supported_node then
    local text = vim.treesitter.get_node_text(supported_node, 0)
    ts_utils.replace_node_text(supported_node, { '`${' .. text .. '}`' })
  end
end

return {
  toggle = function()
    local current_node = vim.treesitter.get_node({ ignore_injections = false })

    if not current_node then
      return
    end

    local template_substitution_node = ts_utils.find_node_parent(current_node, 'template_substitution')

    if template_substitution_node then
      remove_string_interpolation(template_substitution_node)
    else
      add_string_interpolation(current_node)
    end
  end,
}
