local augroup = require('utils').augroup

augroup('conceal', {
  { 'FileType', pattern = 'html,svelte', command = 'setlocal conceallevel=2' },
})

augroup('no_auto_comment', {
  { 'FileType', command = 'setlocal formatoptions-=r formatoptions-=o' },
})

augroup('spell', {
  { 'FileType', pattern = 'gitcommit,markdown', command = 'setlocal spell' },
})

augroup('colorcolumn', {
  { 'FileType', pattern = 'lua', command = 'setlocal colorcolumn=120' },
})

augroup('yank_highlight', {
  {
    'TextYankPost',
    callback = function()
      vim.highlight.on_yank()
    end,
  },
})

augroup('lastplace', {
  {
    'BufReadPost',
    callback = function()
      local test_line_data = vim.api.nvim_buf_get_mark(0, '"')
      local test_line = test_line_data[1]
      local last_line = vim.api.nvim_buf_line_count(0)

      if test_line > 0 and test_line <= last_line then
        vim.api.nvim_win_set_cursor(0, test_line_data)
      end
    end,
  },
})

augroup('lsp_formatting', {
  {
    'BufWritePre',
    pattern = '*.go,*.cs',
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  },
})

augroup('no_modify', {
  { 'BufRead', pattern = '**/node_modules/**', command = 'setlocal nomodifiable' },
})

-- Borrowed from https://github.com/Abstract-IDE/abstract-autocmds
augroup('vim_window_resize', {
  { 'VimResized', command = 'tabdo wincmd =' },
})
