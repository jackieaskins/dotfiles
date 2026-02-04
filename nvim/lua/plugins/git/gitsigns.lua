---@type LazySpec
return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
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
              ---@diagnostic disable-next-line: missing-fields
              gs.nav_hunk(dir, { greedy = false })
            end
          end)

          bsk('n', prefix .. 'C', function()
            ---@diagnostic disable-next-line: missing-fields
            gs.nav_hunk(dir, { target = 'all', greedy = false })
          end)
        end

        -- Actions
        bsk('n', '<leader>hs', gs.stage_hunk)
        bsk('v', '<leader>hs', function()
          gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)
        bsk('n', '<leader>hS', gs.stage_buffer)

        bsk('n', '<leader>hr', gs.reset_hunk)
        bsk('v', '<leader>hr', function()
          gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)
        bsk('n', '<leader>hR', gs.reset_buffer)

        bsk('n', '<leader>hp', gs.preview_hunk)
        bsk('n', '<leader>hi', gs.preview_hunk_inline)

        bsk('n', '<leader>hb', function()
          gs.blame_line({ full = true })
        end)

        bsk('n', '<leader>hd', gs.diffthis)
        bsk('n', '<leader>hD', function()
          gs.diffthis('~')
        end)

        -- Toggles
        bsk('n', '<leader>tb', gs.toggle_current_line_blame)
        bsk('n', '<leader>tw', gs.toggle_word_diff)

        -- Text objects
        bsk({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
      sign_priority = require('sign_priorities').gitsigns,
      trouble = false,
    })
  end,
}
