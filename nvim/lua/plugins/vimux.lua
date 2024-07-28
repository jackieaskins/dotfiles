return {
  'preservim/vimux',
  lazy = true,
  config = function()
    local function set_vimux_orientation()
      vim.g.VimuxOrientation = vim.go.columns > 160 and 'h' or 'v'
    end

    require('utils').augroup('vimux', {
      { 'VimResized', callback = set_vimux_orientation },
    })

    vim.g.VimuxHeight = '40%'
    vim.g.VimuxCloseOnExit = 1
    set_vimux_orientation()
  end,
}
