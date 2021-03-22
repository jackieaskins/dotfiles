" Lightline LSP {{{
let s:error_indicator = ' '
let s:warning_indicator = ' '
let s:info_indicator = '🛈 '
let s:hint_indicator = '! '
let s:ok_indicator = ''

if g:use_builtin_lsp
  let g:lightline#lsp#indicator_errors = s:error_indicator
  let g:lightline#lsp#indicator_warnings = s:warning_indicator
  let g:lightline#lsp#indicator_infos = s:info_indicator
  let g:lightline#lsp#indicator_hints = s:hint_indicator
  let g:lightline#lsp#indicator_ok = s:ok_indicator
else
  let g:lightline#coc#indicator_errors = s:error_indicator
  let g:lightline#coc#indicator_warnings = s:warning_indicator
  let g:lightline#coc#indicator_info = s:info_indicator
  let g:lightline#coc#indicator_hints = s:hint_indicator
  let g:lightline#coc#indicator_ok = s:ok_indicator
endif

function! LightlineLspStatus()
  if g:use_builtin_lsp
    if luaeval('#vim.lsp.buf_get_clients() > 0')
      return luaeval("require('lsp-status').status()")
    endif

    return ''
  endif

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
      \ 'lsp_errors': g:use_builtin_lsp ? 'lightline#lsp#errors' : 'lightline#coc#errors',
      \ 'lsp_warnings': g:use_builtin_lsp ? 'lightline#lsp#warnings' : 'lightline#coc#warnings',
      \ 'lsp_info': g:use_builtin_lsp ? 'lightline#lsp#infos' : 'lightline#coc#info',
      \ 'lsp_hints': g:use_builtin_lsp ? 'lightline#lsp#hints' : 'lightline#coc#hints',
      \ 'lsp_ok': g:use_builtin_lsp ? 'lightline#lsp#ok' : 'lightline#coc#ok'
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
