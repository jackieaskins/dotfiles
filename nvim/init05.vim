" Settings {{{
set nocompatible
set encoding=utf8

" Leader key
nnoremap <Space> <nop>
let mapleader = " "

" Reload vim
nnoremap <Leader>re :source $MYVIMRC<CR>
" }}}

" Plugins {{{
source ~/dotfiles/nvim/plugins.vim
source ~/dotfiles/nvim/plugin-config.vim
lua require'init'
" }}}

" Folds {{{
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
autocmd FileType vim setlocal foldmethod=marker foldlevel=0
highlight Folded guifg=PeachPuff4
set foldlevel=99 " Start folds expanded by default
set foldcolumn=2 " Show fold column with width 2
" }}}

" Windows {{{
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
" }}}

" Spaces & Tabs {{{
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab " tabs are spaces
autocmd FileType cs,java setlocal shiftwidth=4 tabstop=4 softtabstop=4
set list listchars=tab:\ \ ,trail:· " Add dots for spacing
" }}}

" Comments {{{
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " don't auto-comment
autocmd FileType json syntax match Comment +\/\/.\+$+ " enable comments in JSON
" }}}

" UI Config {{{
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
set updatetime=100 " allow GitGutter to update almost instantly
set diffopt+=vertical

if exists('&signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif
" }}}

" Searching {{{
if has('nvim')
  set inccommand=nosplit " show matches when using substitute/replace
endif
set nohlsearch
set incsearch " search as characters are entered
set ignorecase " use case insensitive search
set smartcase " don't use insensitive search when using capital letters
set path+=** " recursively search path
" }}}
