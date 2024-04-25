return {
  'wojciech-kulik/xcodebuild.nvim',
  enabled = require('lsp.utils').is_server_supported('sourcekit'),
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-tree.lua',
    'nvim-treesitter/nvim-treesitter',
  },
  config = true,
  init = function()
    require('installer').register('xcode', {
      ['xcode-build-server'] = { 'brew', 'xcode-build-server' },
      xcbeautify = { 'brew', 'xcbeautify' },
      xcodeproj = { 'gem', 'xcodeproj' },
      pymobiledevice3 = { 'pip', 'pymobiledevice3' },
    })
  end,
  ft = 'swift',
  keys = {
    { '<leader>X', '<cmd>XcodebuildPicker<CR>' },
    { '<leader>xf', '<cmd>XcodebuildProjectManager<CR>' },
    { '<leader>xb', '<cmd>XcodebuildBuild<CR>' },
    { '<leader>xB', '<cmd>XcodebuildCleanBuild<CR>' },
    { '<leader>xr', '<cmd>XcodebuildBuildRun<CR>' },
    { '<leader>xR', '<cmd>XcodebuildRun<CR>' },
    { '<leader>xl', '<cmd>XcodebuildToggleLogs<CR>' },
    { '<leader>xd', '<cmd>XcodebuildSelectDevice<CR>' },
    { '<leader>xx', '<cmd>XcodebuildQuickfixLine<CR>' },
    { '<leader>xa', '<cmd>XcodebuildCodeActions<CR>' },
  },
}
