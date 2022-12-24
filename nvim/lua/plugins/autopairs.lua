return {
  'windwp/nvim-autopairs',
  config = function()
    local Rule = require('nvim-autopairs.rule')
    local autopairs = require('nvim-autopairs')
    local cond = require('nvim-autopairs.conds')

    autopairs.setup({})

    -- Handle spaces between brackets
    -- https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#alternative-version
    local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
    autopairs.add_rules({
      Rule(' ', ' ', '-markdown')
        :with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({
            brackets[1][1] .. brackets[1][2],
            brackets[2][1] .. brackets[2][2],
            brackets[3][1] .. brackets[3][2],
          }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local context = opts.line:sub(col - 1, col + 2)
          return vim.tbl_contains({
            brackets[1][1] .. '  ' .. brackets[1][2],
            brackets[2][1] .. '  ' .. brackets[2][2],
            brackets[3][1] .. '  ' .. brackets[3][2],
          }, context)
        end),
    })

    for _, bracket in pairs(brackets) do
      Rule('', ' ' .. bracket[2])
        :with_pair(cond.none())
        :with_move(function(opts)
          return opts.char == bracket[2]
        end)
        :with_cr(cond.none())
        :with_del(cond.none())
        :use_key(bracket[2])
    end
  end,
}
