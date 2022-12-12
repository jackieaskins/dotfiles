local utils = require('utils')
local map = utils.map

-- Diagnostics
map('n', '<leader>wd', '<cmd>Telescope diagnostics<CR>')
map('n', 'g?', '<cmd>lua vim.diagnostic.open_float(0, { scope = "cursor" })<CR>')
map('n', '[g', vim.diagnostic.goto_prev, { desc = 'vim.diagnostic.goto_prev' })
map('n', ']g', vim.diagnostic.goto_next, { desc = 'vim.diagnostic.goto_next' })
map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>')
map('n', ']e', '<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>')

-- Extended gx
map('n', 'gx', function()
  require('gx').handle_url_under_cursor()
end, { desc = 'Open url under cursor' })

-- Yank to System Clipboard
local yank_keys = { 'd', 'y', 'c' }
for _, key in ipairs(yank_keys) do
  map({ 'n', 'v' }, '<leader>' .. key, '"+' .. key)
end

-- Jumplist
local function jump(key)
  return function()
    return vim.v.count > 1 and "m'" .. vim.v.count .. key or key
  end
end
map('n', 'k', jump('k'), { desc = 'Jump [count] lines up', expr = true })
map('n', 'j', jump('j'), { desc = 'Jump [count] lines down', expr = true })

-- Navigate Quickfix
map('n', '[q', vim.cmd.cprevious)
map('n', ']q', vim.cmd.cnext)
map('n', '[Q', vim.cmd.cfirst)
map('n', ']Q', vim.cmd.clast)
map('n', '[<C-q>', vim.cmd.cpfile)
map('n', ']<C-q>', vim.cmd.cnfile)

-- Navigate Location List
map('n', '[l', vim.cmd.lprevious)
map('n', ']l', vim.cmd.lnext)
map('n', '[L', vim.cmd.lfirst)
map('n', ']L', vim.cmd.llast)
map('n', '[<C-l>', vim.cmd.lpfile)
map('n', ']<C-l>', vim.cmd.lnfile)

-- Navigate Files
map('n', '[n', vim.cmd.previous)
map('n', ']n', vim.cmd.next)
map('n', '[N', vim.cmd.first)
map('n', ']N', vim.cmd.last)

map('n', '<leader>so', '<cmd>luafile %<CR>')
map('n', '<leader>rp', function()
  require('reload').reload_plugins()
end, { desc = 'Reload plugins' })

-- Plugins
-- Diff View
map('n', '<leader>dv', function()
  if vim.wo.diff or vim.bo.filetype == 'DiffviewFiles' then
    vim.cmd.DiffviewClose()
  else
    vim.cmd.DiffviewOpen()
  end
end)

-- LuaSnip
local function luasnip()
  return require('luasnip')
end
map('i', '<C-Y>', function()
  luasnip().expand()
end, { desc = 'Expand snippet' })
map({ 'i', 's' }, '<C-J>', function()
  luasnip().expand_or_jump()
end, { desc = 'Expand snippet or jump to next placeholder' })
map({ 'i', 's' }, '<C-K>', function()
  luasnip().jump(-1)
end, { desc = 'Jump to previous placeholder' })

-- Markdown Preview
map('n', '<leader>mp', vim.cmd.MarkdownPreview)

-- Maximizer
map('n', '<leader>mt', vim.cmd.MaximizerToggle)

-- Neotest
map('n', ']t', function()
  require('neotest').jump.next()
end, { desc = 'Go to next test' })
map('n', '[t', function()
  require('neotest').jump.prev()
end, { desc = 'Go to previous test' })
map('n', ']f', function()
  require('neotest').jump.next({ status = 'failed' })
end, { desc = 'Go to next failed test' })
map('n', '[f', function()
  require('neotest').jump.prev({ status = 'failed' })
end, { desc = 'Go to previous failed test' })

map('n', '<leader>tf', function()
  require('neotest').run.run(vim.fn.expand('%'))
end, { desc = 'Run tests in file' })
map('n', '<leader>tn', function()
  require('neotest').run.run()
end, { desc = 'Run nearest test/namespace' })
map('n', '<leader>tl', function()
  require('neotest').run.run_last()
end, { desc = 'Run last test command' })
map('n', '<leader>to', function()
  require('neotest').output.open()
end, { desc = 'Open nearest test output' })
map('n', '<leader>tO', function()
  require('neotest').output.open({ enter = true })
end, { desc = 'Open and enter nearest test output' })
map('n', '<leader>tt', function()
  require('neotest').summary.toggle()
end, { desc = 'Open test summary window' })
map('n', '<leader>ts', function()
  require('neotest').run.stop()
end, { desc = 'Stop currently running tests' })

-- Neotree
map('n', '<C-n>', '<cmd>Neotree toggle<CR>')
map('n', '<leader>n', '<cmd>Neotree toggle reveal<CR>')

-- Packer
map('n', '<leader>ps', vim.cmd.PackerSync)
map('n', '<leader>pu', vim.cmd.PackerUpdate)
map('n', '<leader>pl', ':PackerLoad ', { silent = false })

-- Startup Time
map('n', '<leader>su', '<cmd>StartupTime --tries 20<CR>')

-- Telescope
map('n', '<leader>ht', '<cmd>Telescope help_tags<CR>')
map('n', '<leader>hi', '<cmd>Telescope highlights<CR>')
map('n', '<leader>km', '<cmd>Telescope keymaps<CR>')
map('n', '<C-p>', '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>')
map('n', '<leader>ff', '<cmd>Telescope find_files find_command=rg,--no-ignore,--hidden,--files<CR>')
map('n', '<leader>rg', ':Telescope grep_string search=', { silent = false })
map('n', '<leader>/', '<cmd>Telescope live_grep only_sort_text=true<CR>')
map('n', '<leader>fw', '<cmd>Telescope grep_string<CR>')
map('n', '<leader>gs', '<cmd>Telescope git_status<CR>')
map('n', '<leader>bu', '<cmd>Telescope buffers sort_mru=true<CR>')
map('n', '<leader>of', '<cmd>Telescope oldfiles cwd_only=true sort_lastused=true include_current_session=true<CR>')
map('n', '<leader>z=', '<cmd>Telescope spell_suggest<CR>')
map('n', '<leader>pp', '<cmd>Telescope packer<CR>')

-- TreeSJ
map('n', 'gJ', vim.cmd.TSJJoin)
map('n', 'gS', vim.cmd.TSJSplit)

-- Vimux
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
    prompt = 'Enter command:',
    completion = 'shellcmd',
  }, function(input)
    if input then
      vim.fn.VimuxRunCommand(input)
    end
  end)
end, { desc = 'VimuxRunCommand' })
