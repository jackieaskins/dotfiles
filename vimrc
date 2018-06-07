" Load plugins
source ~/.vim/plugins.vim

" Colors
syntax on " enable syntax processing

" Material Theme
function! MyHighlights() abort
  let l:yellow    = '#ffcb6b'
  let l:cyan      = '#89ddff'

   exec 'hi jsObjectKey guifg=' l:yellow
   exec 'hi cssProp guifg=' l:cyan
   exec 'hi cssClassName guifg=' l:yellow
endfunction

augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END

set background=dark
if has('termguicolors')
  set termguicolors
endif
let g:material_theme_style = 'dark'
colorscheme material

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
set signcolumn=yes
source ~/.vim/tabline.vim

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
set laststatus=2
set timeoutlen=1000 ttimeoutlen=10 " speeds up switch between modes
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_min_count = 0
let g:airline#extensions#tabline#tab_nr_type = 1 " display tab number in tabs

" ALE
let g:ale_linters = { 'javascript': ['eslint', 'prettier'] }
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'

" Commentary
autocmd FileType ocaml setlocal commentstring=(*\ %s\ *)

" CtrlP
let g:ctrlp_custom_ignore = 'node_modules\|\.DS_Store\|\.git'
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

" Markdown Preview
let vim_markdown_preview_toggle = 1
let vim_markdown_preview_hotkey = '<C-m>'
let vim_markdown_preview_github = 1
let vim_markdown_preview_browser = 'Google Chrome'
let vim_markdown_preview_temp_file = 1

" NerdTree
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore=['node_modules', '\.git']
map <C-n> :NERDTreeToggle<CR>

" Trailing Whitespace
autocmd ColorScheme * highlight ExtraWhitespace guibg=red2
