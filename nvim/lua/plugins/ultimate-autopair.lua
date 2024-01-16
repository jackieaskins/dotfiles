return {
  'altermo/ultimate-autopair.nvim',
  enabled = vim.g.use_ultimate_pairs,
  event = { 'InsertEnter', 'CmdlineEnter' },
  opts = {
    -- Mapping to get newline to work properly for html tags (doesn't attempt to do any autocompletion)
    { '>', '<', newline = true, disable_start = true },
    close = { enable = true },
    cmap = false,
    cr = { enable = true, autoclose = true },
    space2 = { enable = true },
  },
}
