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

    { '<M-S-h>', '<cmd>Treewalker SwapLeft<CR>' },
    { '<M-S-j>', '<cmd>Treewalker SwapDown<CR>' },
    { '<M-S-k>', '<cmd>Treewalker SwapUp<CR>' },
    { '<M-S-l>', '<cmd>Treewalker SwapRight<CR>' },
  },
}
