return {
  'luukvbaal/statuscol.nvim',
  opts = function()
    local builtin = require('statuscol.builtin')

    return {
      ft_ignore = { 'NvimTree' },
      segments = {
        { -- Gitsigns
          sign = { namespace = { 'gitsigns' }, wrap = true, auto = false },
          click = 'v:lua.ScSa',
        },
        { -- Other signs
          sign = { name = { '.*' }, namespace = { '.*' }, auto = false },
          click = 'v:lua.ScSa',
        },
        { text = { builtin.lnumfunc } }, -- Line number
        { text = { builtin.foldfunc }, click = 'v:lua.ScFa' }, -- Fold
        { text = { ' ' }, hl = 'FoldColumn' }, -- Spacer
      },
    }
  end,
}
