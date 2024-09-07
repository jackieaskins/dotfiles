---@type LazySpec
return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
  config = true,
  keys = {
    {
      '<leader>rf',
      function()
        require('refactoring').select_refactor({})
      end,
      mode = { 'x', 'n' },
      desc = 'Show refactoring select',
    },
  },
}
