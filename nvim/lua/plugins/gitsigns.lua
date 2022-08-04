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
    local function go_to_hunk(key, dir)
      bsk('n', key, function()
        if vim.wo.diff then
          return key
        end
        vim.schedule(dir)
        return '<Ignore>'
      end, { expr = true })
    end
    go_to_hunk(']c', gs.next_hunk)
    go_to_hunk('[c', gs.prev_hunk)

    -- Actions
    -- Using gs.[stage/reset]_hunk as rhs didn't allow partial hunk stages
    bsk({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    bsk({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    bsk('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'gs.undo_stage_hunk' })
    bsk('n', '<leader>hp', gs.preview_hunk, { desc = 'gs.preview_hunk' })
    bsk('n', '<leader>hS', gs.stage_buffer, { desc = 'gs.stage_buffer' })
    bsk('n', '<leader>hR', gs.reset_buffer, { desc = 'gs.reset_buffer' })
    bsk('n', '<leader>hb', function()
      gs.blame_line({ full = true })
    end, { desc = 'gs.blame_line({ full = true })' })
    bsk('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'gs.toggle_current_line_blame' })
    bsk('n', '<leader>hd', gs.diffthis, { desc = 'gs.diffthis' })
    bsk('n', '<leader>hD', function()
      gs.diffthis('~')
    end, { desc = 'gs.diffthis("~")' })
    bsk('n', '<leader>td', gs.toggle_deleted, { desc = 'gs.toggle_deleted' })

    -- Text object
    bsk({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
  preview_config = {
    border = 'rounded',
  },
  sign_priority = require('sign_priorities').gitsigns,
  trouble = false,
})
