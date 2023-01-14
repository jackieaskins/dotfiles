return {
  'nvim-treesitter/nvim-treesitter-context',
  opts = {
    javascript = { 'arrow_function' },
    javascriptreact = { 'arrow_function' },
    typescript = { 'arrow_function', 'export_statement' },
    typescriptreact = { 'arrow_function', 'export_statement' },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
}
