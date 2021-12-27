local colors = require('colors')
local success, onenord = pcall(require, 'onenord')

local function spell_hl(color)
  return { fg = colors.none, bg = colors.none, style = 'italic,undercurl', sp = color }
end

if success then
  onenord.setup({
    fade_nc = false,
    styles = {
      comments = 'italic',
      diagnostics = 'undercurl',
      keywords = 'italic',
    },
    custom_highlights = {
      CursorLineNr = { fg = colors.blue, bg = colors.active, style = 'bold' },

      QuickScopePrimary = { fg = colors.dark_blue, style = 'underline' },
      QuickScopeSecondary = { fg = colors.purple, style = 'underline' },

      SpellBad = spell_hl(colors.red),
      SpellCap = spell_hl(colors.yellow),
      SpellRare = spell_hl(colors.purple),
      SpellLocal = spell_hl(colors.cyan),

      TelescopeTitle = { fg = colors.blue },
      TelescopeResultsDiffAdd = { fg = colors.diff_add },
      TelescopeResultsDiffChange = { fg = colors.diff_change },
      TelescopeResultsDiffDelete = { fg = colors.diff_remove },
      TelescopeResultsDiffUntracked = { fg = colors.none },
    },
  })
end

vim.cmd('silent! colorscheme onenord')
