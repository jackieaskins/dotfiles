---@type LazySpec
return {
  'altermo/ultimate-autopair.nvim',
  event = 'InsertEnter',
  config = function()
    local autopair = require('ultimate-autopair')
    autopair.init({
      autopair.extend_default({
        -- Mapping to get newline to work properly for html tags
        {
          '>',
          '<',
          newline = true, -- Properly indents newlines between starting & closing tags
          disable_start = true, -- Prevents < from being entered after typing >
          multiline = false, -- Prevents < from being inserted when <CR> is entered after >
        },
        close = { enable = true },
        cmap = false,
        cr = { enable = true, autoclose = true },
        fastwarp = {
          multi = true,
          {},
          { faster = true, map = '<C-M-e>', cmap = '<C-M-e>' },
        },
        space2 = { enable = true },
      }),
    })
  end,
}
