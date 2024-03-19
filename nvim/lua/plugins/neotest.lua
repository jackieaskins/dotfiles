local function create_key(map)
  local key, context, fn, args, desc = unpack(map)

  return {
    key,
    function()
      require('neotest')[context][fn](type(args) == 'function' and args() or args)
    end,
    desc = desc,
  }
end

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-neotest/nvim-nio',
    'jackieaskins/neotest-jest',
    'antoinemadec/FixCursorHold.nvim',
  },
  opts = function()
    return {
      adapters = { require('neotest-jest') },
      floating = { border = vim.g.border_style },
      output = { open_on_run = false },
      quickfix = { open = false },
    }
  end,
  keys = vim.tbl_map(create_key, {
    { ']t', 'jump', 'next', nil, 'Go to next test' },
    { '[t', 'jump', 'prev', nil, 'Go to previous test' },
    { ']f', 'jump', 'next', { status = 'failed' }, 'Go to next failed test' },
    { '[f', 'jump', 'prev', { status = 'failed' }, 'Go to previous failed test' },

    {
      '<leader>tf',
      'run',
      'run',
      function()
        return vim.fn.expand('%')
      end,
      'Run tests in file',
    },
    { '<leader>tn', 'run', 'run', nil, 'Run nearest test/namespace' },
    { '<leader>tl', 'run', 'run_last', nil, 'Run last test command' },
    { '<leader>ts', 'run', 'stop', nil, 'Stop currently running tests' },

    { '<leader>to', 'output', 'open', nil, 'Open nearest test output' },
    { '<leader>tO', 'output', 'open', { enter = true }, 'Open and enter nearest test output' },

    { '<leader>tt', 'summary', 'toggle', nil, 'Open test summary window' },
  }),
}
