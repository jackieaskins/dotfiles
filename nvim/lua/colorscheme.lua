local colors = require('colors')
local success, onenord = pcall(require, 'onenord')

if success then
  onenord.setup({
    fade_nc = false,
    styles = {
      comments = 'italic',
      diagnostics = 'undercurl',
      keywords = 'italic',
    },
    custom_highlights = {
      CursorLineNr = { fg = colors.blue, bg = colors.active },

      QuickScopePrimary = { fg = colors.dark_blue, style = 'underline' },
      QuickScopeSecondary = { fg = colors.purple, style = 'underline' },

      TelescopeTitle = { fg = colors.blue },
      TelescopeResultsDiffAdd = { fg = colors.diff_add },
      TelescopeResultsDiffChange = { fg = colors.diff_change },
      TelescopeResultsDiffDelete = { fg = colors.diff_remove },
      TelescopeResultsDiffUntracked = { fg = colors.none },
    },
  })
end

vim.cmd('silent! colorscheme onenord')
