local gl = require'galaxyline'
local condition = require'galaxyline.condition'
local colors = require'plugins/galaxyline/colors'

local gls = gl.section

gl.short_line_list = {'NvimTree', 'startify'}

gls.short_line_left = {
  {
    SFileName = {
      provider = 'SFileName',
      condition = condition.buffer_not_empty,
      highlight = {colors.subtle_fg, colors.bg}
    }
  },
  {
    DisplayName = {
      provider = function()
        return '[' .. vim.bo.filetype .. ']'
      end,
      condition = function()
        for _, filetype in ipairs(gl.short_line_list) do
          if filetype == vim.bo.filetype then
            return true
          end
        end

        return false
      end,
      highlight = {colors.bg, colors.blue},
    }
  },
  {
    Empty = {
      provider = function() return '' end,
      highlight = {colors.subtle_fg, colors.bg}
    }
  }
}

gls.short_line_right = {
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
}
