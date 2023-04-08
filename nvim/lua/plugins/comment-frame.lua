return {
  's1n7ax/nvim-comment-frame',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = { '<leader>cf', '<leader>cF' },
  opts = {
    keymap = '<leader>cf',
    multiline_keymap = '<leader>cF',
    languages = {
      sh = { start_str = '#', end_str = '#' },
      vim = { start_str = '"', end_str = '"' },
      zsh = { start_str = '#', end_str = '#' },
    },
  },
}
