local success, catppuccin = pcall(require, 'catppuccin')

if success then
  catppuccin.setup({
    custom_highlights = function(colors)
      local editor_highlights = require('catppuccin.groups.editor').get()

      local telescope_selection = vim.tbl_extend('force', editor_highlights.CursorLine, { fg = colors.peach })

      return {
        CursorLineNr = vim.tbl_extend('force', editor_highlights.CursorLine, editor_highlights.CursorLineNr),

        NeoTreeNormal = { fg = colors.text, bg = colors.base },

        QuickScopePrimary = { fg = colors.sapphire, sp = colors.sapphire, style = { 'underline', 'bold' } },
        QuickScopeSecondary = { fg = colors.pink, sp = colors.pink, style = { 'underline' } },

        TabLine = { fg = colors.text, bg = colors.surface0 },
        TabLineSep = { fg = colors.surface0, bg = colors.base },

        TelescopeResultsDiffAdd = { fg = colors.green },
        TelescopeResultsDiffChange = { fg = colors.yellow },
        TelescopeResultsDiffDelete = { fg = colors.red },
        TelescopeResultsDiffUntracked = { fg = 'NONE' },
        TelescopeSelectionCaret = telescope_selection,
        TelescopeSelection = telescope_selection,

        TreesitterContext = { fg = 'NONE', bg = colors.mantle },

        WinBarNC = { fg = colors.overlay0, bg = '#292d40' },
      }
    end,
    dim_inactive = { enabled = true, shade = 'light', percentage = 0.3 },
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
