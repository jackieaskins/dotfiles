---@type LazySpec
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
        local inc_search = {
          bg = utils.darken(colors.sky, 0.90, colors.base),
          fg = colors.mantle,
        }

        local anchor_link = { fg = colors.blue, style = { 'underline' } }
        local inline_code = { bg = colors.surface0 }

        local custom_highlights = {
          -- Default Highlights
          CurSearch = vim.tbl_extend('force', inc_search, { style = { 'bold' } }),
          FoldColumn = { fg = colors.surface1 },
          Folded = { bg = colors.mantle },
          MatchParen = { bg = colors.none, style = { 'bold' } },
          NormalFloat = { bg = colors.base },
          FloatBorder = { fg = colors.blue, bg = colors.base },
          Pmenu = { fg = colors.surface2, bg = colors.base },
          PmenuSel = { fg = colors.none, bg = colors.surface0 },
          PmenuThumb = { bg = colors.blue },
          StatusLine = { fg = colors.text, bg = colors.base },
          StatusLineSectionSep = { fg = colors.surface0, bg = colors.base },
          TabLine = { fg = colors.text, bg = colors.surface0 },
          TabLineSep = { fg = colors.surface0, bg = colors.base },
          TabLineFill = { bg = colors.base },

          -- Custom Highlights
          WinBarDiagnosticError = { fg = colors.red, bg = colors.base },
          WinBarDiagnosticWarn = { fg = colors.yellow, bg = colors.base },
          WinBarDiagnosticHint = { fg = colors.teal, bg = colors.base },
          WinBarDiagnosticInfo = { fg = colors.sky, bg = colors.base },

          -- Semantic Highlights
          -- Removing because it overwrites custom comment colors, like links
          ['@lsp.type.comment.lua'] = { fg = colors.none },

          -- Treesitter Highlights
          ['@label.vimdoc'] = { fg = colors.mauve, style = { 'bold' } },
          ['@markup.link.label.markdown_inline'] = anchor_link,
          ['@markup.quote'] = { fg = colors.subtext1, style = { 'italic' } },
          ['@markup.raw'] = { fg = colors.lavender },
          ['@markup.raw.markdown_inline'] = inline_code,
          ['@markup.raw.vimdoc'] = inline_code,
          ['@string.special.url'] = anchor_link,

          -- Plugin Highlights
          -- blink.cmp
          BlinkCmpMenuBorder = { link = 'FloatBorder' },
          BlinkCmpDocBorder = { link = 'FloatBorder' },
          BlinkCmpSignatureHelpBorder = { link = 'FloatBorder' },

          -- eyeliner.nvim
          EyelinerPrimary = {
            fg = colors.sapphire,
            style = { 'bold', 'underline' },
          },
          EyelinerSecondary = { fg = colors.pink, style = { 'underline' } },

          -- fzf-lua
          FzfLuaHeaderBind = { fg = colors.blue },
          FzfLuaHeaderText = { fg = colors.mauve },
          FzfLuaFzfInfo = { fg = colors.mauve },
          FzfLuaFzfPointer = { fg = colors.blue },

          -- highlight-undo.nvim
          HighlightUndo = { link = 'IncSearch' },
          HighlightRedo = { link = 'IncSearch' },

          -- markdown.nvim
          RenderMarkdownCodeInline = inline_code,

          -- mini.icons
          MiniIconsGrey = { fg = colors.overlay0 },

          -- nvim-cmp
          CmpItemAbbr = { fg = colors.text },
          CmpItemAbbrMatch = { fg = colors.blue },
          CmpItemMenu = { fg = colors.surface2 },

          -- nvim-lightbulb
          LightBulbVirtText = { bg = colors.none },

          -- nvim-treesitter-context
          TreesitterContext = { fg = colors.text, bg = colors.mantle },
          TreesitterContextLineNumber = { fg = colors.surface1, bg = colors.mantle },

          -- oil.nvim
          -- OilDirHidden = { link = 'OilDir' },
          -- OilFileHidden = { link = 'OilFile' },

          -- snacks.nvim
          SnacksIndent = { fg = colors.surface0 },
        }

        return vim.tbl_extend('force', custom_highlights, require('modes').get_initial_highlights(colors))
      end,
      integrations = {
        blink_cmp = false,
        cmp = true,
        colorful_winsep = { enabled = true, color = 'blue' },
        fidget = true,
        fzf = true,
        gitsigns = true,
        indent_blankline = { enabled = false },
        markdown = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        notify = true,
        semantic_tokens = true,
        snacks = true,
        treesitter = true,
        treesitter_context = false,
      },
    })

    vim.cmd.colorscheme('catppuccin')
  end,
}
