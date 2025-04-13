-- Disable the (slow) builtin query linter
vim.g.query_lint_on = {}

---@type vim.lsp.Config
return {
  cmd = { vim.fn.stdpath('data') .. '/lsp-servers/ts_query_ls/ts_query_ls' },
  settings = {
    parser_install_directories = {
      vim.fn.stdpath('data') .. '/lazy/nvim-treesitter/parser/',
    },
  },
}
