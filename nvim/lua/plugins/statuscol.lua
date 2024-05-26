return {
  'luukvbaal/statuscol.nvim',
  opts = function()
    local builtin = require('statuscol.builtin')

    return {
      segments = {
        { text = { '%s' } }, -- Sign column
        { text = { builtin.lnumfunc } }, -- Line number
        { text = { builtin.foldfunc }, click = 'v:lua.ScFa' }, -- Fold
        { text = { ' ' }, hl = 'FoldColumn' }, -- Spacer
      },
    }
  end,
}
