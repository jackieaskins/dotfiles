local fn = vim.fn
local ts_utils = require('nvim-treesitter.ts_utils')
local locals = require('nvim-treesitter.locals')

local function ts_rename(new_name)
  local node_to_rename = ts_utils.get_node_at_cursor()
  local definition, scope = locals.find_definition(node_to_rename, 0)
  local nodes_to_rename = {
    [node_to_rename:id()] = node_to_rename,
    [definition:id()] = definition,
  }

  for _, node in ipairs(locals.find_usages(definition, scope, 0)) do
    nodes_to_rename[node:id()] = node
  end

  local edits = vim.tbl_map(function(node)
    return {
      range = ts_utils.node_to_lsp_range(node),
      newText = new_name,
    }
  end, vim.tbl_values(nodes_to_rename))

  vim.lsp.util.apply_text_edits(edits, 0, 'utf-8')
end

local function get_definition_in_current_file()
  local params = vim.lsp.util.make_position_params()
  local definitions = vim.lsp.buf_request_sync(0, 'textDocument/definition', params)

  for _, definition in pairs(definitions) do
    for _, res in ipairs(definition.result) do
      local filename = string.gsub(res.uri or res.targetUri, 'file://', '')
      if vim.fn.expand('%:p') == vim.fn.fnamemodify(filename, ':p') then
        return res
      end
    end
  end

  return nil
end

local function is_javascript_file()
  return vim.tbl_contains({ 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }, vim.bo.filetype)
end

local function get_definition_node(lsp_definition)
  if lsp_definition then
    local definition = lsp_definition

    local start_line = definition.range.start.line
    local start_col = definition.range.start.character

    return ts_utils.get_root_for_position(start_line, start_col):named_descendant_for_range(
      start_line,
      start_col,
      start_line,
      start_col
    )
  end

  return locals.find_definition(ts_utils.get_node_at_cursor(), 0)
end

local function get_node_text(node)
  return vim.treesitter.query.get_node_text(node, 0)
end

local function add_alias_to_node(definition_node, new_name, alias_prefix)
  local node_text = get_node_text(definition_node)
  local definition_line, definition_col = definition_node:range()
  local current_node = ts_utils.get_node_at_cursor()
  local current_line, current_col = fn.line('.'), fn.col('.')

  fn.cursor({ definition_line + 1, definition_col + 1 })
  fn.feedkeys('ea' .. alias_prefix .. node_text, 'tx')

  if current_node ~= definition_node then
    fn.cursor({ current_line, current_col })
  else
    fn.feedkeys('B')
  end

  vim.lsp.buf.rename(new_name)

  return true
end

local function update_aliased_node(definition_node, parent, new_name)
  local actual_name = get_node_text(parent:named_child(0))
  local current_node = ts_utils.get_node_at_cursor()
  local current_line, current_col = fn.line('.'), fn.col('.')

  ts_rename(new_name)

  if actual_name == new_name then
    ts_utils.update_selection(0, parent)
    fn.feedkeys('c' .. new_name, 'tx')

    if definition_node ~= current_node then
      fn.cursor({ current_line, current_col })
    end
  end

  return true
end

local function handle_javascript_rename(lsp_definition, new_name)
  local definition_node = get_definition_node(lsp_definition)
  local parent = definition_node:parent()

  if definition_node:type() == 'shorthand_property_identifier_pattern' then
    return add_alias_to_node(definition_node, new_name, ': ')
  end

  if parent:type() == 'pair_pattern' then
    return update_aliased_node(definition_node, parent, new_name)
  end

  if parent:type() == 'import_specifier' then
    if parent:named_child_count() == 1 then
      return add_alias_to_node(definition_node, new_name, ' as ')
    end

    return update_aliased_node(definition_node, parent, new_name)
  end

  return false
end

--[[
  Explanation:
  Updated rename function. If the variable is defined in the current file, use LSP rename. Otherwise, use TreeSitter to
  rename. Also has some custom logic to handle JavaScript imports.

  JavaScript examples:
  Renaming push to p:
    * `const { push } = useHistory();` -> `const { push: p } = useHistory();`
  Renaming p back to push:
    * `const { push: p } = useHistory();` -> `const { push } = useHistory();`

  Renaming useHistory to useHist:
    * `import { useHistory } from "react-router-dom";` -> `import { useHistory as useHist } from "react-router-dom";`
  Renaming useHist back to useHistory:
    * `import { useHistory as useHist } from "react-router-dom";` -> `import { useHistory } from "react-router-dom";`

  Context:
  LSP rename works great if renaming the definition because it also updates references in other files.  LSP rename
  doesn't work as well when renaming something defined in another file, ESPECIALLY in node_modules (Rename should NEVER
  update node_modules).
--]]
return {
  smart_rename = function()
    local node_to_refactor = ts_utils.get_node_at_cursor()
    if not node_to_refactor then
      return
    end

    local current_name = get_node_text(node_to_refactor)

    vim.ui.input({
      prompt = 'New name:',
      default = current_name,
    }, function(new_name)
      if not new_name or #new_name < 1 or current_name == new_name then
        return
      end

      if #vim.lsp.buf_get_clients() == 0 then
        return ts_rename(new_name)
      end

      local lsp_definition = get_definition_in_current_file()

      if is_javascript_file() then
        local successful = handle_javascript_rename(lsp_definition, new_name)
        if successful then
          return
        end
      end

      if not lsp_definition then
        ts_rename(new_name)
      else
        vim.lsp.buf.rename(new_name)
      end
    end)
  end,
}
