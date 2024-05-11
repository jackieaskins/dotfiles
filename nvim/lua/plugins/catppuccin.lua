return {
  'catppuccin/nvim',
  lazy = false,
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      background = { light = 'latte', dark = 'macchiato' },
      custom_highlights = function(colors)
        local utils = require('catppuccin.utils.colors')

        -- This used to referenced highlights with require('catppuccin.groups.editor').get()
        -- but that was broken in https://github.com/catppuccin/nvim/issues/664
        -- For details and workaround: https://github.com/catppuccin/nvim/issues/667
        -- Unfortunately the workaround can't be used here
        -- This hard-codes the highlights I was referencing until there's a better solution
        local cursor_line = {
          bg = utils.vary_color({
            latte = utils.lighten(colors.mantle, 0.70, colors.base),
          }, utils.darken(colors.surface0, 0.64, colors.base)),
        }
        local inc_search = {
          bg = utils.darken(colors.sky, 0.90, colors.base),
          fg = colors.mantle,
        }
        local search = {
          bg = utils.darken(colors.sky, 0.30, colors.base),
          fg = colors.text,
        }

        local telescope_selection = vim.tbl_extend('force', cursor_line, {
          fg = colors.blue,
        })

        return {
          -- Default Highlights
          CurSearch = vim.tbl_extend('force', inc_search, { style = { 'bold' } }),
          CursorLineNr = { fg = colors.blue, bg = cursor_line.bg, style = { 'bold' } },
          Folded = { fg = colors.blue, bg = colors.surface0 },
          NormalFloat = { bg = colors.base },
          StatusLine = { fg = colors.text, bg = colors.base },
          TabLine = { fg = colors.text, bg = colors.surface0 },

          -- Custom Highlights
          WinBarDiagnosticError = { fg = colors.red, bg = colors.base },
          WinBarDiagnosticWarn = { fg = colors.yellow, bg = colors.base },
          WinBarDiagnosticHint = { fg = colors.teal, bg = colors.base },
          WinBarDiagnosticInfo = { fg = colors.sky, bg = colors.base },

          -- Treesitter Highlights
          ['@string.special.url'] = { fg = colors.sky },

          -- Plugin Highlights
          -- highlight-undo.nvim
          HighlightUndo = { link = 'IncSearch' },

          -- markdown.nvim
          markdownH1 = { fg = colors.base, bg = colors.red },
          markdownH2 = { fg = colors.base, bg = colors.peach },
          markdownH3 = { fg = colors.base, bg = colors.yellow },
          markdownH4 = { fg = colors.base, bg = colors.green },
          markdownH5 = { fg = colors.base, bg = colors.sapphire },
          markdownH6 = { fg = colors.base, bg = colors.lavender },

          -- nvim-hlslens
          HlSearchLens = search,

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
        colorful_winsep = { enabled = true, color = 'mauve' },
        diffview = true,
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
