" Load custom settings
if !empty(glob("~/.vim/custom.vim"))
  source ~/.vim/custom.vim
endif

" Load plugins
source ~/.vim/plugins.vim
let g:lightline = {}

" Colors
syntax on " enable syntax processing

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
set timeoutlen=1000 ttimeoutlen=10 " speed up switch between modes

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
" ALE
let g:ale_linters = { 'javascript': ['eslint', 'prettier'] }

" Better Whitespace
let g:better_whitespace_guicolor='#dd7186'

" Closetag
let g:closetag_filenames = '*.html,*.js,*.jsx'
let g:closetag_xhtml_filenames = '*.js,*.jsx'

" Commentary
autocmd FileType ocaml setlocal commentstring=(*\ %s\ *)

" Emmet
let g:user_emmet_leader_key = '<leader>m'
let g:user_emmet_settings = {
      \  'javascript.jsx' : {
      \      'extends' : 'jsx',
      \  },
      \}

" FZF
nnoremap <c-p> :FZF<cr>
augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

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
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_function = {
      \ 'filename': 'LightlineFilename',
      \ 'fugitive': 'fugitive#head',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ ] ],
      \ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
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

" UltiSnips
let g:UltiSnipsJumpForwardTrigger='<leader>n'
let g:UltiSnipsJumpBackwardTrigger='<leader>p'
