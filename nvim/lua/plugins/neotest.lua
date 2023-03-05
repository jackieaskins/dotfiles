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

local M = {
  'nvim-neotest/neotest',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'jackieaskins/neotest-jest',
  },
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

function M.config()
  require('neotest').setup({
    adapters = { require('neotest-jest') },
    output = { open_on_run = false },
    quickfix = { open = false },
  })
end

return M
