---@type LazySpec
return {
  'tomiis4/hypersonic.nvim',
  keys = { { '<leader>rx', '<cmd>Hypersonic<CR>' } },
  cmd = 'Hypersonic',
  opts = { border = vim.g.border_style },
}
