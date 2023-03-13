return {
  'atusy/tsnode-marker.nvim',
  ft = 'markdown',
  init = function()
    local markers = {
      { ft = 'markdown', target = { 'code_fence_content' }, hl_group = 'MarkerCodeFence' },
      { ft = 'help', target = { 'code' }, hl_group = 'MarkerCodeFence' },
    }

    require('utils').augroup(
      'tsnode_marker',
      vim.tbl_map(function(val)
        return {
          'FileType',
          pattern = val.ft,
          callback = function(ctx)
            require('tsnode-marker').set_automark(ctx.buf, {
              target = val.target,
              hl_group = val.hl_group,
            })
          end,
        }
      end, markers)
    )
  end,
}
