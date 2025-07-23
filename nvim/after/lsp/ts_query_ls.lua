-- Disable the (slow) builtin query linter
vim.g.query_lint_on = {}

---@type vim.lsp.Config
return {
  settings = {
    parser_install_directories = {
      vim.fn.stdpath('data') .. '/lazy/nvim-treesitter/parser/',
    },
  },
}
