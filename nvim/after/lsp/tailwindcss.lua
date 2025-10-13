local tailwind_path = 'node_modules/tailwindcss'

---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)

    local dir = vim.fs.find({ tailwind_path }, {
      path = fname,
      upward = true,
    })[1]

    on_dir(vim.fs.dirname(dir and dir:gsub(tailwind_path, '')))
  end,
}
