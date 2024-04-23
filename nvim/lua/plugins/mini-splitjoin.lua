return {
  'echasnovski/mini.splitjoin',
  enabled = false,
  version = false,
  keys = { 'gJ', 'gS' },
  opts = function()
    local gen_hook = require('mini.splitjoin').gen_hook

    local curly = { '%b{}' }

    local pad_curly = gen_hook.pad_brackets({ brackets = curly })
    local add_comma = gen_hook.add_trailing_separator()
    local del_comma = gen_hook.del_trailing_separator()

    return {
      detect = {
        brackets = { '%b()', '%b<>', '%b[]', '%b{}' },
      },
      mappings = { toggle = '', split = 'gS', join = 'gJ' },
      split = { hooks_post = { add_comma } },
      join = { hooks_post = { del_comma, pad_curly } },
    }
  end,
}
