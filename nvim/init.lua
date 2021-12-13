pcall(require, 'impatient')

-- Needed because filetype.nvim disables ftdetect loading
-- https://github.com/nathom/filetype.nvim/issues/9
vim.cmd('runtime! ftdetect/*.vim')
vim.cmd('runtime! ftdetect/*.lua')

require('settings')
require('keymappings')

if require('utils').file_exists('~/dotfiles/nvim/lua/custom.lua') then
  require('custom')
end

require('closer')

require('plugins')
require('lsp')
require('colorscheme')
