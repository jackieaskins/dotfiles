---@type LazySpec
return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = { 'lewis6991/async.nvim' },
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
