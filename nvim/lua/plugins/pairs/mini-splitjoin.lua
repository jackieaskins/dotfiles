local curly_brackets = { '%b{}' }
local curly_opts = { brackets = curly_brackets }

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
        pattern = 'nix',
        callback = function()
          local gen_hook = require('mini.splitjoin').gen_hook

          vim.b.minisplitjoin_config = {
            split = {
              hooks_post = {
                gen_hook.add_trailing_separator({
                  sep = ';',
                  brackets = curly_brackets,
                }),
              },
            },
            join = {
              hooks_post = {
                gen_hook.pad_brackets({
                  brackets = { '%b[]', '%b{}' },
                }),
              },
            },
          }
        end,
      },
      {
        'FileType',
        pattern = 'lua',
        callback = function()
          local gen_hook = require('mini.splitjoin').gen_hook

          vim.b.minisplitjoin_config = {
            join = {
              hooks_post = {
                gen_hook.del_trailing_separator(curly_opts),
                gen_hook.pad_brackets(curly_opts),
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
                require('mini.splitjoin').gen_hook.pad_brackets(curly_opts),
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
          gen_hook.pad_brackets(curly_opts),
        },
      },
    }
  end,
}
