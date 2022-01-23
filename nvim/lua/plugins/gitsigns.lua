-- https://github.com/lewis6991/gitsigns.nvim
local map = require('utils').map

require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function bsk(mode, lhs, rhs, opts)
      local options = { buffer = bufnr }
      if opts then
        options = vim.tbl_extend('force', options, opts)
      end
      map(mode, lhs, rhs, options)
    end

    -- Navigation
    bsk('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    bsk('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

    -- Actions
    bsk({ 'n', 'v' }, '<leader>hs', gs.stage_hunk)
    bsk({ 'n', 'v' }, '<leader>hr', gs.reset_hunk)
    bsk('n', '<leader>hS', gs.stage_buffer)
    bsk('n', '<leader>hu', gs.undo_stage_hunk)
    bsk('n', '<leader>hR', gs.reset_buffer)
    bsk('n', '<leader>hp', gs.preview_hunk)
    bsk('n', '<leader>hb', function()
      gs.blame_line({ full = true })
    end)
    bsk('n', '<leader>tb', gs.toggle_current_line_blame)
    bsk('n', '<leader>hd', gs.diffthis)
    bsk('n', '<leader>hD', function()
      gs.diffthis('~')
    end)
    bsk('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    bsk({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
  preview_config = {
    border = 'rounded',
  },
  trouble = false,
})
