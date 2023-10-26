return {
  'FabijanZulj/blame.nvim',
  cmd = 'ToggleBlame',
  init = function()
    require('utils').augroup('blame_winbar', {
      {
        'FileType',
        pattern = 'blame',
        callback = function()
          vim.opt_local.winbar = ' Blame'
        end,
      },
    })
  end,
}
