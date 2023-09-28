local ft = { 'markdown', 'norg', 'plaintex', 'tex', 'text' }

return {
  'gaoDean/autolist.nvim',
  config = true,
  ft = ft,
  init = function()
    local utils = require('utils')
    utils.augroup('autolist', {
      {
        'FileType',
        pattern = ft,
        callback = function(args)
          local bsk = utils.buffer_map(args.buf)

          bsk('i', '<tab>', '<cmd>AutolistTab<CR>')
          bsk('i', '<s-tab>', '<cmd>AutolistShiftTab<CR>')
          bsk('i', '<CR>', '<CR><cmd>AutolistNewBullet<CR>')
          bsk('n', 'o', 'o<cmd>AutolistNewBullet<CR>')
          bsk('n', 'O', 'O<cmd>AutolistNewBulletBefore<CR>')
          bsk('n', '<CR>', '<cmd>AutolistToggleCheckbox<CR><CR>')
          bsk('n', '<leader>cr', '<cmd>AutolistRecalculate<CR>')

          -- cycle list types with dot-repeat
          bsk('n', '<leader>cn', function()
            require('autolist').cycle_next_dr()
          end, { expr = true })
          bsk('n', '<leader>cp', function()
            require('autolist').cycle_prev_dr()
          end, { expr = true })

          -- functions to recalculate list on edit
          bsk('n', '>>', '>><cmd>AutolistRecalculate<CR>')
          bsk('n', '<<', '<<<cmd>AutolistRecalculate<CR>')
          bsk('n', 'dd', 'dd<cmd>AutolistRecalculate<CR>')
          bsk('v', 'd', 'd<cmd>AutolistRecalculate<CR>')
        end,
      },
    })
  end,
}
