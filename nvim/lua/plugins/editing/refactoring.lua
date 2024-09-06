local function refactor_key(mode, key, refactor_type)
  return {
    key,
    function()
      require('refactoring').refactor(refactor_type)
    end,
    mode = mode,
    desc = refactor_type,
  }
end

---@type LazySpec
return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
  config = true,
  keys = {
    refactor_key('x', '<leader>re', 'Extract Function'),
    refactor_key('x', '<leader>rf', 'Extract Function To File'),
    refactor_key('x', '<leader>rv', 'Extract Variable'),
    refactor_key('n', '<leader>rI', 'Inline Function'),
    refactor_key({ 'n', 'x' }, '<leader>ri', 'Inline Variable'),
    refactor_key('n', '<leader>rb', 'Extract Block'),
    refactor_key('n', '<leader>rB', 'Extract Block To File'),
  },
}
