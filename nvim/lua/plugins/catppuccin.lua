local M = { 'catppuccin/nvim', lazy = false, name = 'catppuccin', priority = 1000 }

function M.config()
  require('catppuccin').setup({
    custom_highlights = function(colors)
      local editor_highlights = require('catppuccin.groups.editor').get()
      local headline_highlights = require('catppuccin.groups.integrations.headlines').get()

      local telescope_selection = vim.tbl_extend('force', editor_highlights.CursorLine, { fg = colors.blue })

      return {
        CurSearch = vim.tbl_extend('force', editor_highlights.IncSearch, { style = { 'bold' } }),

        CursorLineNr = { fg = colors.blue, bg = editor_highlights.CursorLine.bg, style = { 'bold' } },

        Folded = { fg = colors.blue, bg = colors.surface0 },

        Headline1Reverse = { fg = headline_highlights.Headline1.fg },
        Headline2Reverse = { fg = headline_highlights.Headline2.fg },
        Headline3 = { bg = colors.surface0, fg = colors.maroon },
        Headline3Reverse = { fg = colors.maroon },
        Headline4Reverse = { fg = headline_highlights.Headline4.fg },
        Headline5Reverse = { fg = headline_highlights.Headline5.fg },
        Headline6Reverse = { fg = headline_highlights.Headline6.fg },

        HlSearchLens = editor_highlights.Search,

        IndentBlanklineContextChar = { fg = colors.blue },

        MarkerCodeFence = { bg = colors.mantle },

        NormalFloat = { bg = colors.base },

        NvimTreeNormal = { fg = colors.text, bg = colors.base },
        NvimTreeWinSeparator = { fg = colors.surface1, bg = 'NONE' },

        QuickScopePrimary = { fg = colors.sapphire, style = { 'underline', 'bold' } },
        QuickScopeSecondary = { fg = colors.pink, style = { 'underline' } },

        StatusColSep = { fg = colors.surface2 },

        TabLine = { fg = colors.text, bg = colors.surface0 },
        TabLineSep = { fg = colors.surface0, bg = colors.base },

        TelescopePromptPrefix = { fg = colors.blue },
        TelescopeResultsDiffAdd = { fg = colors.green },
        TelescopeResultsDiffChange = { fg = colors.yellow },
        TelescopeResultsDiffDelete = { fg = colors.red },
        TelescopeResultsDiffUntracked = { fg = 'NONE' },
        TelescopeSelection = telescope_selection,
        TelescopeSelectionCaret = telescope_selection,

        WinBarNC = { fg = colors.overlay0 },
      }
    end,
    integrations = {
      headlines = true,
      indent_blankline = { enabled = true, colored_indent_levels = false },
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
      notify = true,
      nvimtree = true,
      treesitter_context = true,
    },
  })

  vim.cmd.colorscheme('catppuccin')
end

return M
