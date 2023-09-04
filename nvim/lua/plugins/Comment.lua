return {
  'numToStr/Comment.nvim',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = function()
    return {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }
  end,
}
