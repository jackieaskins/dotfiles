return {
  'altermo/ultimate-autopair.nvim',
  event = { 'InsertEnter', 'CmdlineEnter' },
  opts = {
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
    space2 = { enable = true },
  },
}
