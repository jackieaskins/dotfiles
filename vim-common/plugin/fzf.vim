let s:fzf_mappings = {
      \ 'ctrl-f': 'preview-page-down',
      \ 'ctrl-b': 'preview-page-up',
      \ 'ctrl-j': 'page-down',
      \ 'ctrl-k': 'page-up',
      \ 'ctrl-a': 'select-all',
      \ }

let s:fzf_bind = ''
for mapping in items(s:fzf_mappings)
  let s:fzf_bind .= mapping[0] . ':' . mapping[1] . ','
endfor
let $FZF_DEFAULT_OPTS .= ' --layout=reverse --bind=' . s:fzf_bind . '?:toggle-preview'

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
let g:fzf_colors = { 'border': ['fg', 'Directory'] }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

nnoremap <C-p> :Files<CR>
nnoremap <Leader>/ :Rg<Space>
nnoremap <Leader>rg :Rg<CR>
nnoremap <Leader>f :Rg<Space><C-r><C-w><CR>
nnoremap <Leader>gs :GFiles?<CR>
