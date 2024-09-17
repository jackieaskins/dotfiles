---@type LazySpec
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    attach_to_untracked = true,
    on_attach = function(bufnr)
      local gs = require('gitsigns')

      local function bsk(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        require('utils').map(mode, lhs, rhs, opts)
      end

      -- Navigation
      for prefix, dir in pairs({
        ['['] = 'prev',
        [']'] = 'next',
      }) do
        bsk('n', prefix .. 'c', function()
          if vim.wo.diff then
            vim.cmd.normal({ prefix .. 'c', bang = true })
          else
            gs.nav_hunk(dir, { greedy = false })
          end
        end)

        bsk('n', prefix .. 'C', function()
          gs.nav_hunk(dir, { target = 'all', greedy = false })
        end)
      end

      -- Actions
      bsk('n', '<leader>hs', gs.stage_hunk)
      bsk('n', '<leader>hr', gs.reset_hunk)
      bsk('v', '<leader>hs', function()
        gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end)
      bsk('v', '<leader>hr', function()
        gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end)
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
    preview_config = { border = MY_CONFIG.border_style },
    sign_priority = require('sign_priorities').gitsigns,
    trouble = false,
  },
}
