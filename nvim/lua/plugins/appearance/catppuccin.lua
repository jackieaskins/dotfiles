---@type LazySpec
return {
  'catppuccin/nvim',
  lazy = false,
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      term_colors = true, -- Setting for baleia.nvim
      background = { light = 'latte', dark = 'mocha' },
      custom_highlights = function(colors)
        local utils = require('catppuccin.utils.colors')

        -- This used to reference highlights with require('catppuccin.groups.editor').get()
        -- but that was broken in https://github.com/catppuccin/nvim/issues/664
        -- For details and workaround: https://github.com/catppuccin/nvim/issues/667
        -- Unfortunately the workaround can't be used here
        -- This hard-codes the highlights I was referencing until there's a better solution
        local inc_search_hl = {
          bg = utils.darken(colors.sky, 0.90, colors.base),
          fg = colors.mantle,
        }
        local cursor_line_hl = {
          bg = utils.vary_color(
            { latte = utils.lighten(colors.mantle, 0.70, colors.base) },
            utils.darken(colors.surface0, 0.64, colors.base)
          ),
        }

        local anchor_link = { fg = colors.blue, style = { 'underline' } }
        local inline_code = { bg = colors.surface0 }

        local custom_highlights = {
          -- Default Highlights
          CurSearch = vim.tbl_extend('force', inc_search_hl, { style = { 'bold' } }),
          FoldColumn = { fg = colors.surface1 },
          Folded = { bg = colors.mantle },
          CursorLineFold = { fg = colors.surface1, bg = cursor_line_hl.bg },
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
          BlinkCmpSource = { fg = colors.surface2 },

          -- eyeliner.nvim
          EyelinerPrimary = { fg = colors.sapphire, style = { 'bold', 'underline' } },
          EyelinerSecondary = { fg = colors.pink, style = { 'underline' } },

          -- LuaSnip
          LuasnipInsertNodeActive = { bg = colors.surface2 },
          LuasnipInsertNodePassive = { bg = colors.surface0 },

          -- mini.icons
          MiniIconsGrey = { fg = colors.overlay0 },

          -- nvim-lightbulb
          LightBulbVirtText = { bg = colors.none },

          -- nvim-treesitter-context
          TreesitterContext = { fg = colors.text, bg = colors.mantle },
          TreesitterContextLineNumber = { fg = colors.surface1, bg = colors.mantle },
        }
        return vim.tbl_extend(
          'force',
          custom_highlights,
          require('modes').get_and_link_mode_highlights(colors, cursor_line_hl)
        )
      end,
      integrations = {
        blink_cmp = true,
        cmp = false,
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
