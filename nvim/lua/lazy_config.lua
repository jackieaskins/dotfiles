local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.o.runtimepath = lazypath .. ',' .. vim.o.runtimepath

require('lazy').setup({
  { import = 'plugins.appearance' },
  { import = 'plugins.comments' },
  {
    import = 'plugins.custom',
    cond = require('utils').file_exists('~/dotfiles/nvim/lua/plugins/custom/*'),
  },
  { import = 'plugins.diagnostics' },
  { import = 'plugins.editing' },
  { import = 'plugins.formatting' },
  { import = 'plugins.git' },
  { import = 'plugins.lsp' },
  { import = 'plugins.misc' },
  { import = 'plugins.navigation' },
  { import = 'plugins.notifications' },
  { import = 'plugins.pairs' },
  { import = 'plugins.syntax' },
  { import = 'plugins.terminal' },
}, {
  change_detection = { notify = false },
  checker = { enabled = true, notify = false },
  dev = {
    path = '~/vim-plugins',
    patterns = MY_CONFIG.is_personal_machine and { 'jackieaskins' } or {},
  },
  git = { timeout = 300 },
  ui = {
    backdrop = 100,
    border = MY_CONFIG.border_style,
    browser = 'local-open',
  },
})

vim.diagnostic.config({
  jump = { float = false },
  underline = false,
  virtual_lines = false,
  virtual_text = { spacing = 1 },
}, require('lazy.core.config').ns)

local map = require('utils').map
map('n', '<leader>lc', '<cmd>Lazy check<CR>')
map('n', '<leader>li', '<cmd>Lazy install<CR>')
map('n', '<leader>ll', '<cmd>Lazy show<CR>')
map('n', '<leader>lp', '<cmd>Lazy profile<CR>')
map('n', '<leader>ls', '<cmd>Lazy sync<CR>')
map('n', '<leader>lu', '<cmd>Lazy update<CR>')
map('n', '<leader>lx', '<cmd>Lazy clean<CR>')
map('n', '<leader>lr', ':Lazy reload ', { silent = false })
