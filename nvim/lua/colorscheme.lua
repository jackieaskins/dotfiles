local colors = require('colors')
local success, onenord = pcall(require, 'onenord')

local function spell_hl(color)
  return { fg = colors.none, bg = colors.none, style = 'italic,undercurl', sp = color }
end

local custom_highlights = {
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
}

if success then
  -- Add sp to underlined highlights because Shade.nvim overlays don't render properly when underlined but no sp is set
  -- https://github.com/neovim/neovim/issues/14453
  local highlights = require('onenord.theme').highlights(colors, require('onenord.config').options)

  local underlined_highlights = {}
  for name, highlight in pairs(highlights) do
    if string.find(highlight.style or '', 'underline') and not highlight.sp then
      underlined_highlights[name] = vim.tbl_extend('force', highlight, {
        sp = highlight.fg,
      })
    end
  end

  onenord.setup({
    fade_nc = false,
    styles = {
      comments = 'italic',
      diagnostics = 'undercurl',
      keywords = 'italic',
    },
    custom_highlights = vim.tbl_extend('force', underlined_highlights, custom_highlights),
  })

  vim.cmd('colorscheme onenord')
end
