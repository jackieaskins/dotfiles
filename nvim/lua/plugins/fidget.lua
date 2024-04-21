return {
  'j-hui/fidget.nvim',
  opts = {
    notification = { window = { border = vim.g.border_style } },
    integration = {
      ['nvim-tree'] = { enable = false },
      ['xcodebuild-nvim'] = { enable = false },
    },
  },
}
