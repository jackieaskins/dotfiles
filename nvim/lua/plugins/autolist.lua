return {
  'gaoDean/autolist.nvim',
  ft = { 'markdown', 'norg', 'plaintex', 'tex', 'text' },
  config = function()
    local map = require('utils').map
    local autolist = require('autolist')

    autolist.setup()

    map('i', '<tab>', '<cmd>AutolistTab<CR>')
    map('i', '<s-tab>', '<cmd>AutolistShiftTab<CR>')
    map('i', '<CR>', '<CR><cmd>AutolistNewBullet<CR>')
    map('n', 'o', 'o<cmd>AutolistNewBullet<CR>')
    map('n', 'O', 'O<cmd>AutolistNewBulletBefore<CR>')
    map('n', '<CR>', '<cmd>AutolistToggleCheckbox<CR><CR>')
    map('n', '<C-r>', '<cmd>AutolistRecalculate<CR>')

    -- cycle list types with dot-repeat
    map('n', '<leader>cn', autolist.cycle_next_dr, { expr = true })
    map('n', '<leader>cp', autolist.cycle_prev_dr, { expr = true })

    -- functions to recalculate list on edit
    map('n', '>>', '>><cmd>AutolistRecalculate<CR>')
    map('n', '<<', '<<<cmd>AutolistRecalculate<CR>')
    map('n', 'dd', 'dd<cmd>AutolistRecalculate<CR>')
    map('v', 'd', 'd<cmd>AutolistRecalculate<CR>')
  end,
}
