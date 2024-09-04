local augroup = require('utils').augroup

----------------------------------------------------------------------
--                             General                              --
----------------------------------------------------------------------

augroup('local_options_overrides', {
  { 'FileType', command = 'setlocal formatoptions-=r formatoptions-=o', desc = 'Do not auto-comment next line' },
  { 'FileType', pattern = 'gitcommit,markdown', command = 'setlocal spell' },
  { 'FileType', pattern = 'lua', command = 'setlocal colorcolumn=120' },
  { 'BufRead', pattern = '**/node_modules/**', command = 'setlocal nomodifiable' },
})

augroup('mode_highlights', {
  {
    'ModeChanged',
    callback = function()
      require('modes').relink_highlights()
      local ok, tint = pcall(require, 'tint')
      if ok then
        tint.refresh()
      end
    end,
  },
})

augroup('mouse', {
  { 'FocusLost', command = 'map <LeftMouse> <nop>' },
  { 'FocusGained', command = 'unmap <LeftMouse>' },
})

augroup('yank_highlight', {
  {
    'TextYankPost',
    callback = function()
      vim.highlight.on_yank()
    end,
  },
})

augroup('save_folds_and_cursor', {
  { 'BufWinLeave', pattern = '?*', command = 'silent! mkview!' },
  { 'BufWinEnter', pattern = '?*', command = 'silent! loadview' },
})

-- Borrowed from https://github.com/Abstract-IDE/abstract-autocmds
augroup('vim_window_resize', {
  { 'VimResized', command = 'tabdo wincmd =' },
})

----------------------------------------------------------------------
--                               LSP                                --
----------------------------------------------------------------------

augroup('lightbulb_attach', {
  {
    'LspAttach',
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if not client or not client.supports_method(vim.lsp.protocol.Methods.textDocument_codeAction) then
        return
      end

      local bufnr = args.buf
      augroup('lightbulb', {
        {
          'CursorHold',
          callback = function()
            require('lsp.lightbulb').update(bufnr)
          end,
          buffer = bufnr,
        },
        {
          { 'InsertEnter', 'BufLeave' },
          callback = function()
            require('lsp.lightbulb').clear(bufnr)
          end,
          buffer = bufnr,
        },
      })
    end,
  },
})
