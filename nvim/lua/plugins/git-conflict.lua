return {
  'akinsho/git-conflict.nvim',
  lazy = false,
  keys = {
    { '<leader>gc', vim.cmd.GitConflictListQf, 'GitConflictListQf', desc = 'GitConflictListQf' },
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
