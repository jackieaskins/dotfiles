local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup('plugins', {
  change_detection = { notify = false },
  checker = { enabled = true, notify = false },
  dev = {
    path = '~/vim-plugins',
    patterns = vim.g.is_personal_machine and { 'jackieaskins' } or {},
  },
  ui = { border = vim.g.border_style },
})
