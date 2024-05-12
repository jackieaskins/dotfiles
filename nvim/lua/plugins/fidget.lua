return {
  'j-hui/fidget.nvim',
  opts = {
    notification = {
      window = {
        border = vim.g.border_style,
        winblend = 0,
      },
    },
    integration = {
      ['nvim-tree'] = { enable = false },
      ['xcodebuild-nvim'] = { enable = false },
    },
  },
}
