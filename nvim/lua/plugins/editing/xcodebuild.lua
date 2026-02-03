---@type LazySpec
return {
  'wojciech-kulik/xcodebuild.nvim',
  ft = 'swift',
  keys = {
    { '<leader>xr', '<cmd>XcodebuildBuildRun<CR>' },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'folke/snacks.nvim',
    'stevearc/oil.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = true,
}
