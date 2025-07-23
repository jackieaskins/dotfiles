---@type LazySpec
return {
  'luukvbaal/statuscol.nvim',
  opts = function()
    local builtin = require('statuscol.builtin')

    return {
      bt_ignore = { 'prompt' },
      ft_ignore = { 'dbui', 'oil', 'snacks_picker_preview' },
      segments = {
        { -- Gitsigns
          sign = { namespace = { 'gitsigns' }, wrap = true, auto = false, foldclosed = true },
          click = 'v:lua.ScSa',
        },
        { -- Other signs
          sign = { name = { '.*' }, namespace = { '.*' }, auto = false, foldclosed = true },
          click = 'v:lua.ScSa',
        },
        { text = { builtin.lnumfunc } }, -- Line number
        { text = { builtin.foldfunc }, click = 'v:lua.ScFa' }, -- Fold
        { text = { ' ' }, hl = 'FoldColumn' }, -- Spacer
      },
    }
  end,
}
