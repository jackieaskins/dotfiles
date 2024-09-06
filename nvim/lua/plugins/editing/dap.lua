local filter_table_by_keys = require('utils').filter_table_by_keys

local debuggers_path = vim.fn.stdpath('data') .. '/debuggers'

-- Debuggers {{{
local debuggers = {
  ['vscode-js-debug'] = function(debuggers_dir)
    local install_dir = debuggers_dir .. '/vscode-js-debug'

    return {
      'rm -rf ' .. install_dir,
      'git clone https://github.com/microsoft/vscode-js-debug ' .. install_dir,
      'cd ' .. install_dir,
      'npm install --legacy-peer-deps',
      'npx gulp vsDebugServerBundle',
      'mv dist out',
    }
  end,
}

local supported_debuggers = vim.g.supported_debuggers and filter_table_by_keys(debuggers, vim.g.supported_debuggers)
  or debuggers
-- }}}

local function dap_key_map(key, fn)
  return {
    key,
    function()
      require('dap')[fn]()
    end,
    desc = 'DAP ' .. fn,
  }
end

---@type LazySpec
return {
  'mfussenegger/nvim-dap',
  cmd = { 'DapContinue', 'DapShowLog', 'DapToggleBreakpoint' },
  init = function()
    require('installer').register('debuggers', supported_debuggers, debuggers_path)
  end,
  keys = {
    dap_key_map('<F8>', 'toggle_breakpoint'),
    dap_key_map('<F5>', 'continue'),
    dap_key_map('<S-F5>', 'terminate'),
    dap_key_map('<F10>', 'step_over'),
    dap_key_map('<F11>', 'step_into'),
    dap_key_map('<S-F11>', 'step_out'),
  },
  dependencies = {
    { 'jbyuki/one-small-step-for-vimkind' },
    {
      'mxsdev/nvim-dap-vscode-js',
      opts = {
        debugger_path = debuggers_path .. '/vscode-js-debug',
        adapters = { 'pwa-node', 'pwa-chrome' },
      },
    },
    {
      'rcarriga/nvim-dap-ui',
      dependencies = 'nvim-neotest/nvim-nio',
      opts = { floating = { border = vim.g.border_style } },
    },
    { 'theHamsta/nvim-dap-virtual-text', config = true },
  },
  config = function()
    local dap = require('dap')

    ----------------------------------------------------------------------
    --                          General Config                          --
    ----------------------------------------------------------------------

    vim.fn.sign_define('DapBreakpoint', {
      text = '●',
      texthl = 'DapBreakpoint',
      linehl = '',
      numhl = '',
    })
    vim.fn.sign_define('DapBreakpointCondition', {
      text = '●',
      texthl = 'DapBreakpointCondition',
      linehl = '',
      numhl = '',
    })
    vim.fn.sign_define('DapLogPoint', {
      text = '◆',
      texthl = 'DapLogPoint',
      linehl = '',
      numhl = '',
    })

    dap.listeners.after.event_initialized.my_config = function()
      require('dapui').open()
    end
    dap.listeners.before.event_terminated.my_config = function()
      require('dap').clear_breakpoints()
      require('dapui').close()
    end
    dap.listeners.before.event_exited.my_config = function()
      require('dap').clear_breakpoints()
      require('dapui').close()
    end

    ----------------------------------------------------------------------
    --                         Debugger Config                          --
    ----------------------------------------------------------------------

    -- one-small-step-for-vimkind {{{
    dap.configurations.lua = {
      {
        type = 'nlua',
        request = 'attach',
        name = 'Attach to running Neovim instance',
      },
    }

    dap.adapters.nlua = function(callback, config)
      callback({
        type = 'server',
        ---@diagnostic disable-next-line: undefined-field
        host = config.host or '127.0.0.1',
        ---@diagnostic disable-next-line: undefined-field
        port = config.port or 8086,
      })
    end
    -- }}}

    -- vscode-js-debug {{{
    local js_languages = { 'javascript', 'javascriptreact', 'svelte', 'typescript', 'typescriptreact', 'vue' }

    for _, language in ipairs(js_languages) do
      require('dap').configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = '1: Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = '2: Launch (Node)',
          processId = function()
            require('dap.utils').pick_process({ filter = 'npm' })
          end,
          cwd = '${workspaceFolder}',
          skipFiles = {
            '<node_internals>/**',
            '${workspaceFolder}/node_modules/**',
          },
          sourceMaps = true,
        },
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = '3: Launch (Chrome)',
          webRoot = '${workspaceFolder}',
          protocol = 'inspector',
          sourceMaps = true,
          userDataDir = false,
          url = function()
            local co = coroutine.running()

            return coroutine.create(function()
              vim.ui.input({
                prompt = 'Enter URL: ',
                default = 'http://localhost:3000',
              }, function(url)
                if url == nil or url == '' then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
        },
      }
      -- }}}
    end
  end,
}

-- vim:foldmethod=marker foldlevel=0
