local success, catppuccin = pcall(require, 'catppuccin')

if success then
  catppuccin.setup({
    custom_highlights = function(colors)
      local editor_highlights = require('catppuccin.groups.editor').get()

      local telescope_selection = vim.tbl_extend('force', editor_highlights.CursorLine, { fg = colors.peach })

      return {
        CursorLineNr = vim.tbl_extend('force', editor_highlights.CursorLine, editor_highlights.CursorLineNr),

        NeoTreeNormal = { fg = colors.text, bg = colors.base },

        QuickScopePrimary = { fg = colors.sapphire, style = { 'underline', 'bold' } },
        QuickScopeSecondary = { fg = colors.pink, style = { 'underline' } },

        TabLine = { fg = colors.text, bg = colors.surface0 },
        TabLineSep = { fg = colors.surface0, bg = colors.base },
        TabLineSel = { fg = colors.base, bg = colors.flamingo },
        TabLineSelSep = { fg = colors.flamingo, bg = colors.base },

        TelescopeResultsDiffAdd = { fg = colors.green },
        TelescopeResultsDiffChange = { fg = colors.yellow },
        TelescopeResultsDiffDelete = { fg = colors.red },
        TelescopeResultsDiffUntracked = { fg = 'NONE' },
        TelescopeSelectionCaret = telescope_selection,
        TelescopeSelection = telescope_selection,

        TreesitterContext = { fg = colors.none, bg = colors.mantle },

        WinBar = { fg = colors.flamingo },
        WinBarNC = { fg = colors.overlay0 },
      }
    end,
    integrations = {
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
      },
      neotest = true,
      neotree = true,
      nvimtree = false,
      treesitter_context = true,
    },
  })

  vim.cmd.colorscheme('catppuccin')
end
