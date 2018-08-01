" Load plugins
source ~/.vim/plugins.vim
let g:lightline = {}

" Colors
syntax on " enable syntax processing

if !empty(glob("~/.vim/custom.vim"))
  source ~/.vim/custom.vim
endif

set background=dark
if has('termguicolors')
  set termguicolors
endif

let g:quantum_black = 1
let g:lightline.colorscheme = 'quantum'
colorscheme quantum

" File specific
autocmd BufRead,BufNewFile *.md setlocal spell

command! Eroutes e config/routes.rb
command! Sroutes sp config/routes.rb
command! Vroutes vs config/routes.rb

" Spaces & Tabs
set shiftwidth=2
set tabstop=2 " number of visual spaces per <TAB>
set softtabstop=2 " number of spaces in tab when editing
set expandtab " tabs are spaces
set list listchars=tab:\ \ ,trail:· " Add dots for spacing

" UI Config
set laststatus=2 " always display status line
set showtabline=2 " always display tabline
set number " show line number for current line
set relativenumber " show line numbers relative to the current line
set showcmd " show command in bottom bar
set cursorline " highlight current line
set wildmenu " visual autocomple for command menu
set showmatch " highlight matching bracket
set backspace=indent,eol,start " allow backspacing over autoindent, line breaks, and start of insert action
set ruler " display the cursor position on the last line of the screen
set autoindent " keep same indent as line you're currently on
set confirm " raise a dialog asking if you want to save changes when exiting
set splitright " make vertical splits open on right
set splitbelow " make horizontal splits open on botom

if exists('&signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" Searching
set incsearch " search as characters are entered
set ignorecase " use case insensitive search
set smartcase " don't use insensitive search when using capital letters

" Map Ctrl-J, Ctrl-K, Ctrl-H, Ctrl-L to move windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"" Plugins
" Airline
" set timeoutlen=1000 ttimeoutlen=10 " speeds up switch between modes
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" let g:airline#extensions#tabline#show_buffers = 0
" let g:airline#extensions#tabline#show_close_button = 0
" let g:airline#extensions#tabline#show_splits = 0
" let g:airline#extensions#tabline#show_tab_type = 0
" let g:airline#extensions#tabline#tab_min_count = 0
" let g:airline#extensions#tabline#tab_nr_type = 1 " display tab number in tabs

" ALE
let g:ale_linters = { 'javascript': ['eslint', 'prettier'] }
" let g:ale_sign_error = '●'
" let g:ale_sign_warning = '●'

" Commentary
autocmd FileType ocaml setlocal commentstring=(*\ %s\ *)

" CtrlP
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/](_site|\.git|node_modules|vendors)$',
      \ 'file': '\v\.(DS_Store|jpg|png|jpeg)'
      \ }
let g:crtlp_match_window = 'bottom,order:ttb'
let g:ctrlp_show_hidden = 1
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

" Emmet
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
let g:user_emmet_settings = {
      \  'javascript.jsx' : {
      \      'extends' : 'jsx',
      \  },
      \}

" GitGutter
set updatetime=100 " allows GitGutter to update almost instantly

" Gundo
noremap <F5> :GundoToggle<CR>

" JSX
let g:jsx_ext_required = 0

" Lightline
let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'fugitive', 'readonly', 'filename' ] ],
      \ 'right': [ [ 'linter_errors', 'linter_warnings', 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ }
let g:lightline.component = {
      \ 'lineinfo': ' %3l:%-2v',
      \ }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_function = {
      \ 'filename': 'LightlineFilename',
      \ 'readonly': 'LightlineReadonly',
      \ 'fugitive': 'LightlineFugitive',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline.tabline = {
  \ 'left': [ [ 'tabs' ] ],
  \ 'right': [ [ ] ],
  \ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction
function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ' ' . branch : ''
  endif
  return ''
endfunction

" Markdown Preview
let vim_markdown_preview_toggle = 1
let vim_markdown_preview_hotkey = '<C-m>'
let vim_markdown_preview_github = 1
let vim_markdown_preview_browser = 'Google Chrome'
let vim_markdown_preview_temp_file = 1

" NerdTree
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore = ['node_modules', '\.git', '\.DS_Store']
map <C-n> :NERDTreeToggle<CR>
