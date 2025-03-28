local utils = require('utils')
local augroup, map = utils.augroup, utils.map

----------------------------------------------------------------------
--                             General                              --
----------------------------------------------------------------------
map('n', '<leader>so', '<cmd>source %<CR>')
map('n', '<leader>co', function()
  require('convert').show_convert_select()
end)

----------------------------------------------------------------------
--                   Clipboard and Visual Select                    --
----------------------------------------------------------------------

-- Yank to/from System Clipboard
local yank_keys = { 'c', 'C', 'd', 'D', 'p', 'P', 'y', 'Y' }
for _, key in ipairs(yank_keys) do
  map({ 'n', 'v' }, '<leader>' .. key, '"+' .. key)
end

-- Borrowed from https://github.com/Abstract-IDE/abstract-autocmds
-- Keep selection after indenting
map('x', '<', '<gv')
map('x', '>', '>gv')
-- Don't overwrite clipboard when deleting empty line with dd
map('n', 'dd', function()
  -- TODO: Check all lines, not just first
  if vim.v.count == 1 and vim.api.nvim_get_current_line():match('^%s*$') then
    return '"_dd'
  else
    return 'dd'
  end
end, { noremap = true, expr = true })

-- Don't overwrite clipboard on x
-- https://www.reddit.com/r/neovim/comments/1e1dmpw
map('n', 'x', '"_x')

-- https://github.com/neovim/neovim/issues/26449
map({ 'i', 's' }, '<C-e>', function()
  utils.snippet_stop()
end)

----------------------------------------------------------------------
--                           Auto-indent                            --
----------------------------------------------------------------------

-- https://www.reddit.com/r/neovim/comments/17mrka2/comment/k7n3d9b
map('n', 'i', function()
  if #vim.fn.getline('.') == 0 then
    return [["_cc]]
  else
    return 'i'
  end
end, { expr = true, desc = 'Properly indent empty line on insert' })

----------------------------------------------------------------------
--                           Diagnostics                            --
----------------------------------------------------------------------

map('n', '[e', '<cmd>lua vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })<CR>')
map('n', ']e', '<cmd>lua vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })<CR>')

----------------------------------------------------------------------
--                               LSP                                --
----------------------------------------------------------------------

-- Unmap some of the default LSP mappings
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'grr')
vim.keymap.del({ 'n', 'x' }, 'gra')

augroup('lsp_keymaps', {
  {
    'LspAttach',
    callback = function(args)
      local bsk = utils.buffer_map(args.buf)
      bsk('n', 'K', function()
        vim.lsp.buf.hover({ silent = true })
      end)
      bsk({ 'i', 'n' }, '<C-S>', function()
        vim.lsp.buf.signature_help()
      end, { desc = 'vim.lsp.buf.signature_help' })

      bsk('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'vim.lsp.buf.rename' })
      bsk('n', '<leader>bf', function()
        vim.lsp.buf.format({ async = true })
      end, { desc = 'vim.lsp.buf.format' })

      bsk('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'vim.lsp.buf.code_action' })
      bsk('x', '<leader>ca', vim.lsp.buf.code_action, { desc = 'vim.lsp.buf.range_code_action' })

      bsk('n', '<leader>ih', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
      end, { desc = 'vim.lsp.inlay_hint toggle' })

      bsk('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'vim.lsp.buf.add_workspace_folder' })
      bsk('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'vim.lsp.buf.remove_workspace_folder' })
      bsk('n', '<leader>wl', '<cmd>lua =vim.lsp.buf.list_workspace_folders()<CR>')
    end,
  },
})

----------------------------------------------------------------------
--                             Jumplist                             --
----------------------------------------------------------------------

local function jump(key)
  return function()
    return vim.v.count > 1 and "m'" .. vim.v.count .. key or key
  end
end
map('n', 'k', jump('k'), { desc = 'Jump [count] lines up', expr = true })
map('n', 'j', jump('j'), { desc = 'Jump [count] lines down', expr = true })

----------------------------------------------------------------------
--                              Runner                              --
----------------------------------------------------------------------

vim.tbl_map(function(value)
  local key, fn = value[1], value[2]

  map('n', key, function()
    require('runner')[fn]()
  end, { desc = 'runner - ' .. fn })
end, {
  { '<leader>vo', 'open_runner' },
  { '<leader>vt', 'toggle_pane' },
  { '<leader>vq', 'close_runner' },
  { '<leader>vi', 'interrupt_runner' },
  { '<leader>vl', 'run_last_command' },
  { '<leader>vc', 'clear_terminal_screen' },
})

map('n', '<leader>vr', function()
  vim.ui.input({
    prompt = 'Enter command: ',
    completion = 'shellcmd',
  }, function(input)
    if input then
      require('runner').run_command(input)
    end
  end)
end, { desc = 'runner - run_command' })

map('n', '<leader>vL', function()
  require('runner').interrupt_runner()
  require('runner').run_last_command()
end, { desc = 'runner - interrupt_runner_and_run_last_command' })
