return {
  'akinsho/git-conflict.nvim',
  lazy = false,
  keys = {
    { '<leader>cq', vim.cmd.GitConflictListQf, 'GitConflictListQf' },
  },
  opts = {
    default_mappings = {
      ours = 'co',
      theirs = 'ct',
      none = 'c0',
      both = 'cb',
      next = ']x',
      prev = '[x',
    },
  },
}
