local map = require('utils').map

vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = false

map('n', '<leader>gr', function()
  pcall(vim.fn.VimuxInterruptRunner)
  vim.fn.VimuxRunCommand('godot')
end, { buffer = true, silent = true })

map('n', '<leader>gc', function()
  local scene = vim.fn.fnamemodify(vim.fn.bufname(), ':.:r')
  vim.fn.VimuxRunCommand('godot "' .. scene .. '.tscn"')
end, { buffer = true, silent = true })
