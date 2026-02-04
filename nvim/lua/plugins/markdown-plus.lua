---@type LazySpec
return {
  'yousefhadder/markdown-plus.nvim',
  ft = 'markdown', -- Load on markdown files by default
  config = function()
    require('markdown-plus').setup()
  end,
}
