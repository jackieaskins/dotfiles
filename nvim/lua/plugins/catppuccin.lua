local M = { 'catppuccin/nvim', lazy = false, name = 'catppuccin', priority = 1000 }

function M.config()
  require('catppuccin').setup({
    custom_highlights = function(colors)
      local editor_highlights = require('catppuccin.groups.editor').get()

      local telescope_selection = vim.tbl_extend('force', editor_highlights.CursorLine, { fg = colors.peach })

      return {
        CurSearch = vim.tbl_extend('force', editor_highlights.IncSearch, { style = { 'bold' } }),

        CursorLineNr = { fg = colors.blue, style = { 'bold' } },

        Folded = { fg = colors.blue, bg = colors.mantle },

        HlSearchLens = editor_highlights.Search,

        IndentBlanklineContextChar = { fg = colors.blue },

        NormalFloat = { bg = colors.base },

        NvimTreeEmptyFolderName = { fg = colors.blue },
        NvimTreeFolderIcon = { fg = colors.blue },
        NvimTreeFolderName = { fg = colors.blue },
        NvimTreeGitDeleted = { fg = colors.red },
        NvimTreeGitDirty = { fg = colors.yellow },
        NvimTreeGitNew = { fg = colors.blue },
        NvimTreeImageFile = { fg = colors.text },
        NvimTreeIndentMarker = { fg = colors.overlay0 },
        NvimTreeNormal = { fg = colors.text, bg = colors.base },
        NvimTreeOpenedFile = { fg = colors.pink },
        NvimTreeOpenedFolderName = { fg = colors.blue },
        NvimTreeRootFolder = { fg = colors.lavender, style = { 'bold' } },
        NvimTreeSpecialFile = { fg = colors.flamingo },
        NvimTreeStatuslineNc = { fg = colors.mantle, bg = colors.mantle },
        NvimTreeSymlink = { fg = colors.pink },
        NvimTreeWinSeparator = { fg = colors.surface1, bg = 'NONE' },

        QuickScopePrimary = { fg = colors.sapphire, style = { 'underline', 'bold' } },
        QuickScopeSecondary = { fg = colors.pink, style = { 'underline' } },

        TabLine = { fg = colors.text, bg = colors.surface0 },
        TabLineSep = { fg = colors.surface0, bg = colors.base },

        TelescopeResultsDiffAdd = { fg = colors.green },
        TelescopeResultsDiffChange = { fg = colors.yellow },
        TelescopeResultsDiffDelete = { fg = colors.red },
        TelescopeResultsDiffUntracked = { fg = 'NONE' },
        TelescopeSelection = telescope_selection,
        TelescopeSelectionCaret = telescope_selection,

        TreesitterContext = { bg = colors.mantle },

        WinBarNC = { fg = colors.overlay0 },
      }
    end,
    integrations = {
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
      nvimtree = false,
      treesitter_context = true,
    },
  })

  vim.cmd.colorscheme('catppuccin')
end

return M
