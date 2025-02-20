---@type LazySpec
return {
  'altermo/ultimate-autopair.nvim',
  event = 'InsertEnter',
  ---@module 'ultimate-autopair'
  ---@type prof.config
  opts = {
    bs = { single_delete = true },
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
  },
}
