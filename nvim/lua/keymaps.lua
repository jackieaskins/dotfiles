local map = require('utils').map

-- Extended gx
map('n', 'gx', function()
  require('gx').handle_url_under_cursor()
end, { desc = 'Open url under cursor' })

-- Yank to System Clipboard
map({ 'n', 'v' }, '<leader>y', '"+y')

-- Jumplist
local function jump(key)
  return function()
    return vim.v.count > 1 and "m'" .. vim.v.count .. key or key
  end
end
map('n', 'k', jump('k'), { desc = 'Jump [count] lines up', expr = true })
map('n', 'j', jump('j'), { desc = 'Jump [count] lines down', expr = true })

-- Window Management
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

-- Navigate Quickfix
map('n', '[q', '<cmd>cprevious<CR>')
map('n', ']q', '<cmd>cnext<CR>')
map('n', '[Q', '<cmd>cfirst<CR>')
map('n', ']Q', '<cmd>clast<CR>')
map('n', '[<C-q>', '<cmd>cpfile<CR>')
map('n', ']<C-q>', '<cmd>cnfile<CR>')

-- Navigate Location List
map('n', '[l', '<cmd>lprevious<CR>')
map('n', ']l', '<cmd>lnext<CR>')
map('n', '[L', '<cmd>lfirst<CR>')
map('n', ']L', '<cmd>llast<CR>')
map('n', '[<C-l>', '<cmd>lpfile<CR>')
map('n', ']<C-l>', '<cmd>lnfile<CR>')

map('n', '<leader>so', '<cmd>luafile %<CR>')
map('n', '<leader>rp', function()
  require('reload').reload_plugins()
end, { desc = 'Reload plugins' })

-- Plugins
-- Docs View
map('n', '<leader>dv', '<cmd>DocsViewToggle<CR>')

-- Markdown Preview
map('n', '<leader>mp', '<cmd>MarkdownPreview<CR>')

-- Maximizer
map('n', '<leader>mt', '<cmd>MaximizerToggle<CR>')

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

-- Packer
map('n', '<leader>ps', '<cmd>PackerSync<CR>')
map('n', '<leader>pu', '<cmd>PackerUpdate<CR>')
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

-- Tree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>n', '<cmd>NvimTreeFindFileToggle<CR>')

-- Vimux
map('n', '<leader>vt', '<cmd>VimuxTogglePane<CR>')
map('n', '<leader>vi', '<cmd>VimuxInterruptRunner<CR>')
map('n', '<leader>vc', '<cmd>VimuxClearTerminalScreen<CR>')
map('n', '<leader>vq', '<cmd>VimuxCloseRunner<CR>')
map('n', '<leader>vl', '<cmd>VimuxRunLastCommand<CR>')
map('n', '<leader>vr', function()
  local input = vim.fn.input('Enter command: ', '', 'shellcmd')
  if input and input ~= '' then
    vim.fn['VimuxRunCommand'](input)
  end
end)
