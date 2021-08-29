if v:version < 802
  nnoremap <Leader>sw :StripWhitespace<CR>

  let g:better_whitespace_guicolor = '#dd7186'
  let g:better_whitespace_filetypes_blacklist = [
        \ 'diff',
        \ 'gitcommit',
        \ 'unite',
        \ 'qf',
        \ 'help',
        \ 'markdown'
        \ ]
endif
