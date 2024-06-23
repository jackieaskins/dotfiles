return {
  'quolpr/quicktest.nvim',
  enabled = vim.g.test_plugin == 'quicktest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'm00qek/baleia.nvim',
  },
  opts = function()
    return {
      adapters = {
        require('quicktest.adapters.vitest'),
      },
    }
  end,
  keys = function()
    local function qt_key_map(map)
      local key, fn, arg, desc = unpack(map)
      return {
        key,
        function()
          require('quicktest')[fn](arg)
        end,
        desc = desc,
      }
    end

    return vim.tbl_map(qt_key_map, {
      { '<leader>tr', 'run_line', nil, '[T]est [R]un Line' },
      { '<leader>tR', 'run_file', nil, '[T]est [R]un File' },
      { '<leader>td', 'run_dir', nil, '[T]est [D]ir' },
      { '<leader>ta', 'run_all', nil, '[T]est [A]ll' },
      { '<leader>tp', 'run_previous', nil, '[T]est Run [P]revious' },
      { '<leader>tf', 'toggle_win', 'popup', '[T]oggle Test [F]loat' },
      { '<leader>ts', 'toggle_win', 'split', '[T]oggle Test [S]plit' },
    })
  end,
}
