return {
  'akinsho/git-conflict.nvim',
  lazy = false,
  keys = {
    { '<leader>gc', vim.cmd.GitConflictListQf, 'GitConflictListQf', desc = 'GitConflictListQf' },
  },
  config = true,
}
