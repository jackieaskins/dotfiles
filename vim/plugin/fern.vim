nnoremap <silent> <C-n> :Fern . -drawer -toggle<CR>
nnoremap <silent> <Leader>n :Fern . -drawer -toggle -reveal=%<CR>

let g:fern#disable_default_mappings = 1
let g:fern#drawer_width = 50
let g:fern#default_hidden = 1
let g:fern#hide_cursor = 1
let g:fern#renderer = 'nerdfont'

let g:fern_git_status#disable_ignored = 1

function! s:init_fern() abort
  nnoremap <Plug>(fern-custom-action-close-drawer) :<C-u>FernDo close<CR>
  nmap <buffer><silent> <Plug>(fern-custom-action-open-and-close)
      \ <Plug>(fern-action-open)
      \ <Plug>(fern-custom-action-close-drawer)

  nmap <buffer><expr>
        \ <Plug>(fern-custom-action-smart-open)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-custom-action-open-and-close)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )

  nmap <buffer><silent> <CR> <Plug>(fern-custom-action-smart-open)
  nmap <buffer><silent> o <Plug>(fern-custom-action-smart-open)

  nmap <buffer><silent> <Tab> <Plug>(fern-action-open)<C-w><C-p>
  nmap <buffer><silent> <C-v> <Plug>(fern-action-open:vsplit) <Plug>(fern-custom-action-close-drawer)
  nmap <buffer><silent> <C-s> <Plug>(fern-action-open:split) <Plug>(fern-custom-action-close-drawer)
  nmap <buffer><silent> <C-t> <Plug>(fern-action-open:tabedit) <Plug>(fern-custom-action-close-drawer)

  nmap <buffer><silent> h <Plug>(fern-action-collapse)
  nmap <buffer><silent> l <Plug>(fern-action-expand)

  nmap <buffer><silent> R <Plug>(fern-action-reload:all)
  nmap <buffer><silent> r <Plug>(fern-action-rename)
  nmap <buffer><silent> n <Plug>(fern-action-new-path)
  nmap <buffer><silent> m <Plug>(fern-action-move)
  nmap <buffer><silent><nowait> d <Plug>(fern-action-remove)
  nmap <buffer><silent> c <Plug>(fern-action-copy)
  nmap <buffer><silent> - <Plug>(fern-action-mark:toggle)
endfunction

augroup init_fern
  autocmd! *
  autocmd FileType fern call s:init_fern()
  autocmd FileType fern setlocal norelativenumber
  autocmd FileType fern setlocal nonumber
augroup END
