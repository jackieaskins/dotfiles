return {
  'j-hui/fidget.nvim',
  opts = {
    integration = {
      ['nvim-tree'] = { enable = false },
      ['xcodebuild-nvim'] = { enable = false },
    },
    notification = {
      window = {
        border = vim.g.border_style,
        winblend = 0,
      },
    },
    progress = {
      ignore = { 'jdtls' },
    },
  },
}
