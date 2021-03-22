if g:use_builtin_lsp
  lua require'lsp'

  augroup jdt_setup
    autocmd!
    autocmd BufReadCmd jdt://* call luaeval('require"jdtls-setup".handle_jdt_uri(_A)', expand('<amatch>'))
  augroup END

  function! ReloadLsp()
    :lua vim.lsp.stop_client(vim.lsp.get_active_clients())
    :edit
  endfunction
  command LspReload call ReloadLsp()
endif
