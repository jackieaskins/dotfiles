---@type LazySpec
return {
  'knubie/vim-kitty-navigator',
  cond = vim.env.TERM == 'xterm-kitty' and not vim.env.TMUX,
}
