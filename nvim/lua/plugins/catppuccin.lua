return {
  'catppuccin/nvim',
  lazy = false,
  name = 'catppuccin',
  commit = '9703f227bfab20d04bcee62d2f08f1795723b4ae',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      background = { light = 'latte', dark = 'macchiato' },
      custom_highlights = function(colors)
        local editor_highlights = require('catppuccin.groups.editor').get()

        local telescope_selection = vim.tbl_extend('force', editor_highlights.CursorLine, {
          fg = colors.blue,
        })

        return {
          -- Default Highlights
          CurSearch = vim.tbl_extend('force', editor_highlights.IncSearch, {
            style = { 'bold' },
          }),
          CursorLineNr = {
            fg = colors.blue,
            bg = editor_highlights.CursorLine.bg,
            style = { 'bold' },
          },
          Folded = { fg = colors.blue, bg = colors.surface0 },
          NormalFloat = { bg = colors.base },
          StatusLine = { fg = colors.text, bg = colors.base },
          TabLine = { fg = colors.text, bg = colors.surface0 },

          -- Custom Highlights
          WinBarDiagnosticError = { fg = colors.red, bg = colors.base },
          WinBarDiagnosticWarn = { fg = colors.yellow, bg = colors.base },
          WinBarDiagnosticHint = { fg = colors.teal, bg = colors.base },
          WinBarDiagnosticInfo = { fg = colors.sky, bg = colors.base },

          -- Plugin Highlights
          -- highlight-undo.nvim
          HighlightUndo = { link = 'IncSearch' },

          -- nvim-hlslens
          HlSearchLens = editor_highlights.Search,

          -- nvim-lightbulb
          LightBulbVirtText = { bg = colors.none },

          -- nvim-tree.lua
          NvimTreeExecFile = { style = { 'underline', 'bold' } },
          NvimTreeNormal = { fg = colors.text, bg = colors.base },
          NvimTreeWinSeparator = { fg = colors.surface1, bg = colors.none },

          -- nvim-treesitter-context
          TreesitterContext = { fg = colors.text, bg = colors.mantle },

          -- quick-scope
          QuickScopePrimary = { fg = colors.sapphire, style = { 'underline', 'bold' } },
          QuickScopeSecondary = { fg = colors.pink, style = { 'underline' } },

          -- telescope.lua
          TelescopePromptPrefix = { fg = colors.blue },
          TelescopeResultsDiffAdd = { fg = colors.green },
          TelescopeResultsDiffChange = { fg = colors.yellow },
          TelescopeResultsDiffDelete = { fg = colors.red },
          TelescopeResultsDiffUntracked = { fg = colors.none },
          TelescopeSelection = telescope_selection,
          TelescopeSelectionCaret = telescope_selection,
        }
      end,
      integrations = {
        fidget = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
          scope_color = 'blue',
        },
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
        symbols_outline = true,
        treesitter_context = true,
      },
    })

    vim.cmd.colorscheme('catppuccin')
  end,
}
