inoremap <silent><expr> <c-space> coc#refresh()
let g:coc_config_home = '~/dotfiles/vim'
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-eslint',
      \ 'coc-highlight',
      \ 'coc-html',
      \ 'coc-java',
      \ 'coc-json',
      \ 'coc-marketplace',
      \ 'coc-prettier',
      \ 'coc-python',
      \ 'coc-snippets',
      \ 'coc-solargraph',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ ]

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <Leader>qf <Plug>(coc-fix-current)
nmap <Leader>rn <Plug>(coc-rename)
nmap <Leader>sy :<C-u>CocList -I symbols<cr>
nmap <Leader>d :<C-u>CocList diagnostics<cr>

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"" coc-eslint
nmap <Leader>ef :CocCommand eslint.executeAutofix<CR>

"" coc-snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

"" coc-tsserver
nnoremap <Leader>tf :CocCommand tsserver.executeAutofix<CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
