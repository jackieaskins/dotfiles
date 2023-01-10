local map = require('utils').map

return {
  'kevinhwang91/nvim-hlslens',
  init = function()
    map('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
    map('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
    map('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]])
    map('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]])
    map('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
    map('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])
  end,
  config = { calm_down = true },
}
