local utils = require('utils')
local map = utils.map

----------------------------------------------------------------------
--                             General                              --
----------------------------------------------------------------------
map('n', '<leader>so', '<cmd>source %<CR>')
map('n', '<leader>re', '<cmd>restart<CR>')

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

map('n', '<C-s>', vim.lsp.buf.signature_help)

local lsp_renames = {
  { '<leader>rn', 'grn' },
  { '<leader>ca', 'gra' },
  { 'gd', '<C-]>' },
  { 'gpd', '<C-M-]>' },
  { 'gr', 'grr' },
  { 'gpr', 'grR' },
  { 'gi', 'gri' },
  { 'gpi', 'grI' },
}

for _, maps in ipairs(lsp_renames) do
  map('n', maps[1], function()
    Snacks.notify.error('Use ' .. maps[2] .. ' instead of ' .. maps[1], {
      title = 'Awkward! Try this...',
    })
  end)
end

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
