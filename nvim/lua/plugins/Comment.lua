-- JSX Pull Request: https://github.com/numToStr/Comment.nvim/pull/133
return {
  'numToStr/Comment.nvim',
  branch = 'jsx',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    pre_hook = function(ctx)
      return require('Comment.jsx').calculate(ctx)
    end,
  },
}
