local gls = require'galaxyline'.section
local colors = require'plugins/galaxyline/colors'
local modes = require'plugins/galaxyline/modes'

gls.right = {
  {
    FileType = {
      provider = function() return vim.bo.filetype .. ' ' end,
      highlight = {colors.subtle_fg, colors.bg},
      separator = ' ',
      separator_highlight = {colors.subtle_fg, colors.bg}
    }
  },
  {
    LineColumn = {
      provider = 'LineColumn',
      highlight = {colors.fg, colors.section_bg},
      separator = ' ',
      separator_highlight = {colors.fg, colors.section_bg}
    }
  },
  {
    LinePercent = {
      provider = 'LinePercent',
      highlight = {colors.fg, colors.section_bg},
      separator = ' │',
      separator_highlight = {colors.fg, colors.section_bg}
    }
  },
  {
    Suffix = {
      provider = function()
        modes.set_highlight('Suffix')
        return '▊'
      end,
      highlight = {colors.blue, colors.bg}
    }
  }
}
