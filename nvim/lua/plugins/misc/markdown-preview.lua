---@type LazySpec
return {
  'iamcco/markdown-preview.nvim',
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  ft = 'markdown',
  keys = {
    { '<leader>mp', vim.cmd.MarkdownPreview, desc = 'MarkdownPreview' },
  },
}
