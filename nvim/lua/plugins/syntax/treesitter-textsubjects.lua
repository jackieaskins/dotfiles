---@type LazySpec
return {
  'RRethy/nvim-treesitter-textsubjects',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup({

      textsubjects = {
        enable = true,
        prev_selection = ',',
        keymaps = {
          ['.'] = 'textsubjects-smart',
          ['a;'] = 'textsubjects-container-outer',
          ['i;'] = 'textsubjects-container-inner',
        },
      },
    })
  end,
}
