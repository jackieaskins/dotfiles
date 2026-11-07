---@type LazySpec
return {
  'nemanjamalesija/ts-expand-hover.nvim',
  ft = { 'javascript', 'typescript', 'typescriptreact' },
  config = function()
    require('ts_expand_hover').setup({
      float = {
        border = vim.o.winborder,
      },
    })
  end,
}
