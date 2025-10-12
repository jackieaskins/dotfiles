---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(vim.fs.dirname(vim.fs.find({ 'node_modules/tailwindcss' }, { path = fname, upward = true })[1]))
  end,
}
