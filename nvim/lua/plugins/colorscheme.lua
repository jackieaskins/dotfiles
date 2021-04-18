local cmd = vim.cmd

vim.g.quantum_black = 1

require'utils'.augroup('custom_colors', {
  {'ColorScheme', '*', 'highlight link NormalFloat NONE'},
})

cmd 'silent! colorscheme quantum'
