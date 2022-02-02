" Lightline Separators {{{
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
" }}}

" Lightline COC {{{
let g:lightline#coc#indicator_errors = ' '
let g:lightline#coc#indicator_warnings = ' '
let g:lightline#coc#indicator_info = '🛈 '
let g:lightline#coc#indicator_hints = '! '
let g:lightline#coc#indicator_ok = ''

function! LightlineLspStatus()
  return get(g:, 'coc_status', '')
endfunction
" }}}

" Lightline File Functions {{{
function! FilenameHelper(fileRef, filetype, buftype)
  if a:filetype == 'fzf'
    return '[FZF]'
  endif

  if a:filetype == 'fern'
    return '[Fern]'
  endif

  if a:buftype ==# 'terminal'
    return '[Terminal]'
  endif

  if expand(a:fileRef) =~ '^jdt://.*'
    let filename = split(expand(a:fileRef), '%3C')[-1]
    let filename = substitute(filename, '(', '.', '')
    return substitute(filename, '.class', '', '')
  endif

  "" vim-common/config.vim -> v/config.vim
  if expand(a:fileRef . ':t') !=# ''
    return pathshorten(fnamemodify(expand(a:fileRef), ':~:.'))
  endif

  return '[No Name]'
endfunction

function! LightlineFilename()
  "" vim-common/config.vim -> v/config.vim
  return FilenameHelper('%', &filetype, &buftype)
endfunction

function! LightlineTabFilename(n)
  "" vim-common/config.vim -> v/config.vim
  let bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  let bufFiletype = getbufvar(bufnr, '&filetype')
  let bufType = getbufvar(bufnr, '&buftype')

  return FilenameHelper('#' . bufnr, bufFiletype, bufType)
endfunction

function! LightlineFiletype()
  if index(['', 'gitcommit'], &filetype) < 0
    return &filetype . ' ' . nerdfont#find(expand('%'))
  endif

  return 'no ft'
endfunction
" }}}

" Lightline Components {{{
let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'readonly', 'filename', 'modified' ],
      \           [ 'lsp_status' ] ],
      \ 'right': [ ['lsp_info', 'lsp_warnings', 'lsp_errors', 'lsp_ok', 'lsp_hints' ],
      \            [ 'lineinfo', 'percent' ],
      \            [ 'filetype' ] ]
      \ }
let g:lightline.inactive = {
      \ 'left': [ [ 'filename', 'modified' ] ],
      \ 'right': [ [ 'lineinfo', 'percent' ] ],
      \ }
let g:lightline.component_function = {
      \ 'filename': 'LightlineFilename',
      \ 'filetype': 'LightlineFiletype',
      \ 'lsp_status': 'LightlineLspStatus',
      \ }
let g:lightline.component_expand = {
      \ 'lsp_errors': 'lightline#coc#errors',
      \ 'lsp_warnings': 'lightline#coc#warnings',
      \ 'lsp_info': 'lightline#coc#info',
      \ 'lsp_hints': 'lightline#coc#hints',
      \ 'lsp_ok': 'lightline#coc#ok',
      \ }
let g:lightline.component_type = {
      \ 'lsp_warnings': 'warning',
      \ 'lsp_errors': 'error',
      \ 'lsp_info': 'info',
      \ 'lsp_hints': 'hint',
      \ 'lsp_ok': 'left'
      \ }

let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ ] ],
      \ }
let g:lightline.tab_component_function = {
      \ 'filename': 'LightlineTabFilename'
      \ }
let g:lightline.tab = {
      \ 'active': ['filename', 'modified'],
      \ 'inactive': ['tabnum', 'filename', 'modified']
      \ }
" }}}

" vim:foldmethod=marker
