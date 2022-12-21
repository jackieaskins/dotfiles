return {
  'nvim-treesitter/nvim-treesitter-context',
  config = function()
    require('treesitter-context').setup({
      javascript = { 'arrow_function' },
      javascriptreact = { 'arrow_function' },
      typescript = { 'arrow_function', 'export_statement' },
      typescriptreact = { 'arrow_function', 'export_statement' },
    })
  end,
}
