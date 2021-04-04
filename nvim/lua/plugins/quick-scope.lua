local augroup = require'utils'.augroup

augroup('quick_scope', {
  'autocmd ColorScheme * highlight QuickScopePrimary guifg=Orange',
  'autocmd ColorScheme * highlight QuickScopeSecondary guifg=Red',
})
