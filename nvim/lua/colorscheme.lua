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

      IndentBlanklineContextChar = { fg = colors.dark_blue },

      WinBar = { fg = colors.blue, bg = colors.bg },
      WinBarNC = { fg = colors.light_gray, bg = colors.bg },

      NeoTreeDirectoryIcon = { link = 'NvimTreeFolderIcon' },
      NeoTreeDirectoryName = { link = 'NvimTreeFolderName' },
      NeoTreeSymbolicLinkTarget = { link = 'NvimTreeSymlink' },
      NeoTreeRootName = { link = 'NvimTreeRootFolder' },
      NeoTreeFileNameOpened = { link = 'NvimTreeOpenedFile' },

      NeoTreeExpander = { fg = colors.selection }, -- Used for collapsed/expanded icons.
      NeoTreeDotfile = { fg = colors.fg },

      NeoTreeGitIgnored = { fg = colors.selection },
      NeoTreeGitModified = { fg = colors.yellow },
      NeoTreeGitUnstaged = { fg = colors.orange },
      NeoTreeGitUntracked = { fg = colors.orange },
    },
  })

  vim.cmd.colorscheme('onenord')
end
