---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup({
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = {
              query = { '@function.outer', '@class.outer' },
              desc = 'Go to start of next function/class',
            },
          },
          goto_previous_start = {
            ['[m'] = {
              query = { '@function.outer', '@class.outer' },
              desc = 'Go to start of previous function/class',
            },
          },
          goto_next_end = {
            [']M'] = {
              query = { '@function.outer', '@class.outer' },
              desc = 'Go to end of next function/class',
            },
          },
          goto_previous_end = {
            ['[M'] = {
              query = { '@function.outer', '@class.outer' },
              desc = 'Go to end of previous function/class',
            },
          },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['aF'] = '@call.outer',
            ['iF'] = '@call.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',
          },
        },
        swap = {
          enable = true,
          swap_next = { ['<leader>a'] = '@parameter.inner' },
          swap_previous = { ['<leader>A'] = '@parameter.inner' },
        },
      },
    })
  end,
}
