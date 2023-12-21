return {
  'altermo/ultimate-autopair.nvim',
  enabled = vim.g.use_ultimate_pairs,
  event = { 'InsertEnter', 'CmdlineEnter' },
  opts = {
    close = { enable = true },
    cmap = false,
    cr = { enable = true, autoclose = true },
    space2 = { enable = true },
  },
}
