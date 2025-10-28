---@type LazySpec
return {
  'altermo/ultimate-autopair.nvim',
  event = 'InsertEnter',
  config = function()
    local autopair = require('ultimate-autopair')

    autopair.init({
      autopair.extend_default({
        bs = {
          single_delete = true,
          delete_from_end = false,
        },
        close = { enable = true },
        cmap = false,
        cr = {
          enable = true,
          autoclose = true,
        },
        extensions = {
          filetype = {
            nft = { 'snacks_picker_input' },
          },
        },
        fastwarp = {
          multi = true,
          { map = '<M-e>', rmap = '<M-E>' },
          { faster = true, map = '<C-M-e>', rmap = '<C-M-E>' },
        },
        space2 = { enable = true },

        -- Mapping to get newline to work properly for html tags
        {
          '>',
          '<',
          newline = true, -- Properly indents newlines between starting & closing tags
          disable_start = true, -- Prevents < from being entered after typing >
          multiline = false, -- Prevents < from being inserted when <CR> is entered after >
        },
      }),

      ---@diagnostic disable-next-line: assign-type-mismatch
      { profile = require('ultimate-autopair.experimental.addons_.comma_after_table').init },
      ---@diagnostic disable-next-line: assign-type-mismatch
      { profile = require('ultimate-autopair.experimental.addons_.delete_comma_with_pair').init },
    })
  end,
}
