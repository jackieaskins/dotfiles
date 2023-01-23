return {
  'nvim-treesitter/nvim-treesitter-context',
  opts = {
    patterns = {
      default = {
        'class',
        'function',
        'method',
        'for',
        'while',
        'if',
        'elseif',
        'else',
        'switch',
        'case',
        'interface',
        'struct',
        'enum',
      },
      javascript = { 'arrow_function' },
      javascriptreact = { 'arrow_function' },
      typescript = { 'arrow_function', 'export_statement' },
      typescriptreact = { 'arrow_function', 'export_statement' },
    },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
}
