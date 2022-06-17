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
      WinBar = { fg = colors.light_gray },

      CursorLineNr = { fg = colors.blue, bg = colors.active, style = 'bold' },
      Identifier = { fg = colors.blue, gui = 'bold' },

      QuickScopePrimary = { fg = colors.dark_blue, sp = colors.dark_blue, style = 'underline' },
      QuickScopeSecondary = { fg = colors.purple, sp = colors.purple, style = 'underline' },

      SpellBad = spell_hl(colors.red),
      SpellCap = spell_hl(colors.yellow),
      SpellRare = spell_hl(colors.purple),
      SpellLocal = spell_hl(colors.cyan),

      TelescopeTitle = { fg = colors.blue },
      TelescopeResultsDiffAdd = { fg = colors.diff_add },
      TelescopeResultsDiffChange = { fg = colors.diff_change },
      TelescopeResultsDiffDelete = { fg = colors.diff_remove },
      TelescopeResultsDiffUntracked = { fg = colors.none },

      NeotestAdapterName = { fg = colors.purple },
      NeotestDir = { fg = colors.cyan },
      NeotestFile = { fg = colors.cyan },
      NeotestNamespace = { fg = colors.blue },
      NeotestFailed = { fg = colors.dark_red },
      NeotestPassed = { fg = colors.green },
      NeotestRunning = { fg = colors.yellow },
      NeotestSkipped = { fg = colors.cyan },
    },
  })

  vim.cmd('colorscheme onenord')
end
