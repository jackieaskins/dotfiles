require'nvim-treesitter.configs'.setup {
  autotag = {enable = true, skip_close_shortcut = '\\>'},
  context_commentstring = {enable = true},
  ensure_installed = 'maintained',
  highlight = {enable = true},
  indent = {enable = true},
  playground = {enable = true},
  refactor = {highlight_definitions = {enable = true}},
}

local M = {}

--[[
  Explanation:
  Updated rename function. If the variable is defined in the current file, use LSP rename.
  Otherwise, use TreeSitter Refactor smart rename.

  Context:
  LSP rename works great if renaming the definition because it also updates references
  in other files.  LSP rename doesn't work as well when renaming something defined in
  another file, ESPECIALLY in node_modules (Rename should NEVER update node_modules).

  TODO:
  Better handle renaming imported/destructured values
--]]
function M.smart_rename()
  local params = require('vim.lsp.util').make_position_params()
  local definitions = vim.lsp.buf_request_sync(0, 'textDocument/definition', params)

  local function has_match(tbl, check_fn) return #vim.tbl_filter(check_fn, tbl) > 0 end

  local is_definition_in_current_file = has_match(vim.tbl_values(definitions), function(definition)
    return has_match(definition.result, function(res)
      local filename = string.gsub(res.uri or res.targetUri, 'file://', '')
      return vim.fn.expand('%:p') == vim.fn.fnamemodify(filename, ':p')
    end)
  end)

  if is_definition_in_current_file then
    vim.lsp.buf.rename()
  else
    require('nvim-treesitter-refactor.smart_rename').smart_rename()
  end
end

require'my_utils'.map('n', '<leader>rn',
                      '<cmd>lua require"my_plugins/treesitter".smart_rename()<CR>')

return M
