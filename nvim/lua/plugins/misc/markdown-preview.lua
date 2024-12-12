---@type LazySpec
return {
  'iamcco/markdown-preview.nvim',
  build = ':call mkdp#util#install()',
  ft = 'markdown',
  keys = {
    { '<leader>mp', vim.cmd.MarkdownPreview, desc = 'MarkdownPreview' },
  },
}
