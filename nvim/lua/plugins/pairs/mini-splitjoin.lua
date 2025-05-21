local curly = { brackets = { '%b{}' } }

---@type LazySpec
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
  init = function()
    require('utils').augroup('splitjoin_overrides', {
      {
        'FileType',
        pattern = 'lua',
        callback = function()
          local gen_hook = require('mini.splitjoin').gen_hook

          vim.b.minisplitjoin_config = {
            join = {
              hooks_post = {
                gen_hook.del_trailing_separator(curly),
                gen_hook.pad_brackets(curly),
              },
            },
          }
        end,
      },
      {
        'FileType',
        pattern = 'json',
        callback = function()
          vim.b.minisplitjoin_config = {
            join = {
              hooks_post = {
                require('mini.splitjoin').gen_hook.pad_brackets(curly),
              },
            },
          }
        end,
      },
    })
  end,
  opts = function()
    local gen_hook = require('mini.splitjoin').gen_hook

    return {
      detect = {
        brackets = { '%b()', '%b<>', '%b[]', '%b{}' },
      },
      mappings = { toggle = '', split = '', join = '' },
      join = {
        hooks_post = {
          gen_hook.del_trailing_separator(),
          gen_hook.pad_brackets(curly),
        },
      },
    }
  end,
}
