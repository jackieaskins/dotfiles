---@type LazySpec
return {
  'aaronik/treewalker.nvim',
  ---@module 'treewalker'
  ---@type Opts
  opts = {},
  keys = {
    { '<M-h>', '<cmd>Treewalker Left<CR>' },
    { '<M-j>', '<cmd>Treewalker Down<CR>' },
    { '<M-k>', '<cmd>Treewalker Up<CR>' },
    { '<M-l>', '<cmd>Treewalker Right<CR>' },
  },
}
