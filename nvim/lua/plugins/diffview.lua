return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  init = function()
    require('utils').map('n', '<leader>dv', function()
      if vim.wo.diff or vim.bo.filetype == 'DiffviewFiles' then
        vim.cmd.DiffviewClose()
      else
        vim.cmd.DiffviewOpen()
      end
    end)
  end,
}
