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
    end,
  },
})

augroup('yank_highlight', {
  {
    'TextYankPost',
    callback = function()
      vim.hl.on_yank()
    end,
  },
})

augroup('save_folds_and_cursor', {
  {
    'BufWinLeave',
    pattern = '?*',
    callback = function(args)
      local filetype = vim.fn.getbufvar(args.buf, '&filetype')

      if filetype ~= 'gitcommit' then
        vim.cmd('silent! mkview!')
      end
    end,
  },
  {
    'BufWinEnter',
    pattern = '?*',
    callback = function(args)
      local filetype = vim.fn.getbufvar(args.buf, '&filetype')

      if filetype ~= 'gitcommit' then
        vim.cmd('silent! loadview')
      end
    end,
  },
})

-- Borrowed from https://github.com/Abstract-IDE/abstract-autocmds
augroup('vim_window_resize', {
  { 'VimResized', command = 'tabdo wincmd =' },
})

----------------------------------------------------------------------
--                               LSP                                --
----------------------------------------------------------------------

augroup('lsp_folding', {
  {
    'LspAttach',
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if not client or not client:supports_method(vim.lsp.protocol.Methods.textDocument_foldingRange) then
        return
      end

      local winid = vim.fn.bufwinid(args.buf)
      vim.api.nvim_set_option_value('foldmethod', 'expr', { win = winid })
      vim.api.nvim_set_option_value('foldexpr', 'v:lua.vim.lsp.foldexpr()', { win = winid })
    end,
  },
})
