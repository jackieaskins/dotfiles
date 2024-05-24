return {
  'echasnovski/mini.splitjoin',
  version = false,
  keys = {
    {
      'gJ',
      function()
        require('splitjoin.join').join()
      end,
    },
    {
      'gS',
      function()
        require('splitjoin.split').split()
      end,
    },
  },
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
      mappings = { toggle = '', split = '', join = '' },
      split = { hooks_post = { add_comma } },
      join = { hooks_post = { del_comma, pad_curly } },
    }
  end,
}
