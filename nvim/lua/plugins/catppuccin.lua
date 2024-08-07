return {
  'catppuccin/nvim',
  lazy = false,
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      term_colors = true, -- Setting for baleia.nvim
      background = { light = 'latte', dark = 'macchiato' },
      custom_highlights = function(colors)
        local utils = require('catppuccin.utils.colors')

        -- This used to reference highlights with require('catppuccin.groups.editor').get()
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

        local telescope_selection = vim.tbl_extend('force', cursor_line, {
          fg = colors.blue,
        })

        local anchor_link = { fg = colors.blue, style = { 'underline' } }
        local inline_code = { bg = colors.surface0 }

        local custom_highlights = {
          -- Default Highlights
          CurSearch = vim.tbl_extend('force', inc_search, { style = { 'bold' } }),
          CursorLineNr = { fg = colors.blue, style = { 'bold' } },
          FoldColumn = { fg = colors.surface1 },
          Folded = { bg = colors.surface0 },
          NormalFloat = { bg = colors.base },
          FloatBorder = { fg = colors.blue, bg = colors.base },
          StatusLine = { fg = colors.text, bg = colors.base },
          TabLine = { fg = colors.text, bg = colors.surface0 },

          -- Custom Highlights
          WinBarDiagnosticError = { fg = colors.red, bg = colors.base },
          WinBarDiagnosticWarn = { fg = colors.yellow, bg = colors.base },
          WinBarDiagnosticHint = { fg = colors.teal, bg = colors.base },
          WinBarDiagnosticInfo = { fg = colors.sky, bg = colors.base },

          -- Treesitter Highlights
          ['@markup.link.label.markdown_inline'] = anchor_link,
          ['@markup.quote'] = { fg = colors.subtext1, style = { 'italic' } },
          ['@markup.raw.markdown_inline'] = inline_code,
          ['@string.special.url'] = anchor_link,

          -- Plugin Highlights
          -- LuaSnip
          LuasnipChoiceNodeActive = { link = 'Visual' },
          LuasnipChoiceNodePassive = { link = 'Visual' },
          LuasnipInsertNodeActive = { link = 'Visual' },
          LuasnipInsertNodePassive = { link = 'Visual' },

          -- highlight-undo.nvim
          HighlightUndo = { link = 'IncSearch' },

          -- markdown.nvim
          RenderMarkdownCodeInline = inline_code,

          -- mini.icons
          MiniIconsGrey = { fg = colors.overlay0 },

          -- nvim-lightbulb
          LightBulbVirtText = { bg = colors.none },

          -- nvim-tree.lua
          NvimTreeExecFile = { style = { 'underline', 'bold' } },
          NvimTreeNormal = { fg = colors.text, bg = colors.base },
          NvimTreeWinSeparator = { fg = colors.surface1, bg = colors.none },

          -- nvim-treesitter-context
          TreesitterContext = { fg = colors.text, bg = colors.mantle },

          -- telescope.lua
          TelescopePromptPrefix = { fg = colors.blue },
          TelescopeResultsDiffAdd = { fg = colors.green },
          TelescopeResultsDiffChange = { fg = colors.yellow },
          TelescopeResultsDiffDelete = { fg = colors.red },
          TelescopeResultsDiffUntracked = { fg = colors.none },
          TelescopeSelection = telescope_selection,
          TelescopeSelectionCaret = telescope_selection,
        }

        return vim.tbl_extend('force', custom_highlights, require('modes').get_initial_highlights(colors))
      end,
      integrations = {
        colorful_winsep = { enabled = true, color = 'blue' },
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
