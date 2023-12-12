local M = { 'catppuccin/nvim', lazy = false, name = 'catppuccin', priority = 1000 }

function M.config()
  require('catppuccin').setup({
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
        CursorLineNr = { fg = colors.blue, bg = editor_highlights.CursorLine.bg, style = {
          'bold',
        } },
        Folded = { fg = colors.blue, bg = colors.surface0 },
        NormalFloat = { bg = colors.base },
        TabLine = { fg = colors.text, bg = colors.surface0 },
        TabLineSep = { fg = colors.surface0, bg = colors.base },

        -- Plugin Highlights
        -- highlight-undo.nvim
        HighlightUndo = { link = 'IncSearch' },

        -- nvim-hlslens
        HlSearchLens = editor_highlights.Search,

        -- nvim-lightbulb
        LightBulbVirtText = { bg = colors.none },

        -- nvim-tree.lua
        NvimTreeNormal = { fg = colors.text, bg = colors.base },
        NvimTreeWinSeparator = { fg = colors.surface1, bg = colors.none },

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
      neogit = true,
      neotest = true,
      notify = true,
      nvimtree = true,
      treesitter_context = true,
    },
  })

  vim.cmd.colorscheme('catppuccin')
end

return M
