local gls = require'galaxyline'.section
local fileinfo = require'galaxyline.provider_fileinfo'
local condition = require'galaxyline.condition'
local modes = require'plugins/galaxyline/modes'
local colors = require'plugins/galaxyline/colors'

gls.left = {
  {
    Prefix = {
      provider = function()
        modes.set_highlight('Prefix')
        return '▊ '
      end,
      highlight = {colors.blue, colors.bg}
    }
  },
  {
    ViMode = {
      provider = function()
        modes.set_highlight('ViMode')
        return modes.get_label() .. ' '
      end,
      highlight = {colors.blue, colors.bg},
    }
  },
  {
    FileInfo = {
      provider = function()
        return '  ' .. fileinfo.get_file_icon() .. fileinfo.get_current_file_name()
      end,
      condition = condition.buffer_not_empty,
      highlight = {colors.fg, colors.section_bg},
    }
  },
  {
    Empty = {
      provider = function() return '' end,
      highlight = {colors.fg, colors.bg}
    }
  }
}
