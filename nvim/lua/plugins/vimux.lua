return {
  'preservim/vimux',
  config = function()
    local function set_vimux_orientation()
      vim.g.VimuxOrientation = vim.go.columns > 160 and 'h' or 'v'
    end

    require('utils').augroup('vimux', {
      { 'VimResized', { callback = set_vimux_orientation } },
    })

    vim.g.VimuxHeight = '40'
    vim.g.VimuxCloseOnExit = 1
    set_vimux_orientation()

    local map = require('utils').map

    map('n', '<leader>vt', vim.cmd.VimuxTogglePane, { desc = 'VimuxTogglePane' })
    map('n', '<leader>vi', vim.cmd.VimuxInterruptRunner, { desc = 'VimuxInterruptRunner' })
    map('n', '<leader>vc', vim.cmd.VimuxClearTerminalScreen, { desc = 'VimuxClearTerminalScreen' })
    map('n', '<leader>vq', vim.cmd.VimuxCloseRunner, { desc = 'VimuxCloseRunner' })
    map('n', '<leader>vk', function()
      vim.ui.input({ prompt = 'Enter keys:' }, function(input)
        if input then
          vim.fn.VimuxSendKeys(input)
        end
      end)
    end, { desc = 'VimuxSendKeys' })
    map('n', '<leader>vl', vim.cmd.VimuxRunLastCommand, { desc = 'VimuxRunLastCommand' })
    map('n', '<leader>vL', function()
      vim.fn.VimuxInterruptRunner()
      vim.fn.VimuxRunLastCommand()
    end, { desc = 'VimuxInterruptRunner | VimuxRunLastCommand' })
    map('n', '<leader>vo', vim.cmd.VimuxOpenRunner, { desc = 'VimuxOpenRunner' })
    map('n', '<leader>vr', function()
      vim.ui.input({
        prompt = 'Enter command: ',
        completion = 'shellcmd',
      }, function(input)
        if input then
          vim.fn.VimuxRunCommand(input)
        end
      end)
    end, { desc = 'VimuxRunCommand' })
  end,
}
