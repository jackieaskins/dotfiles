local augroup = require('utils').augroup

-- Disable auto-comments
augroup('no_auto_comment', {
  { 'FileType', { command = 'setlocal formatoptions-=r formatoptions-=o' } },
})

augroup('spell', {
  { 'FileType', { pattern = 'gitcommit,markdown', command = 'setlocal spell' } },
})

augroup('colorcolumn', {
  { 'FileType', { pattern = 'lua', command = 'setlocal colorcolumn=120' } },
})

augroup('lastplace', {
  {
    'BufReadPost',
    {
      callback = function()
        local test_line_data = vim.api.nvim_buf_get_mark(0, '"')
        local test_line = test_line_data[1]
        local last_line = vim.api.nvim_buf_line_count(0)

        if test_line > 0 and test_line <= last_line then
          vim.api.nvim_win_set_cursor(0, test_line_data)
        end
      end,
    },
  },
})

augroup('lsp_formatting', {
  {
    'BufWritePre',
    {
      pattern = '*.go',
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    },
  },
})

-- Plugins
-- Nvim-Lint
augroup('lint', {
  {
    { 'BufWritePost', 'InsertLeave' },
    {
      pattern = '*.gd',
      callback = function()
        require('lint').try_lint()
      end,
    },
  },
})

-- Neoformat
augroup('format_on_save', {
  { 'BufWritePre', {
    callback = function()
      require('plugins.neoformat').format_on_save()
    end,
  } },
})
