" Settings {{{
set nocompatible
set encoding=utf8

" Leader key
nnoremap <Space> <nop>
let mapleader = " "

let g:vimsyn_embed = 'lPr'

" Reload Vim
nnoremap <Leader>re :source $MYVIMRC<CR>

" Custom settings
if !empty(glob("~/dotfiles/vim/custom.vim"))
  source ~/dotfiles/vim/custom.vim
endif
" }}}

" Plugins {{{
source ~/dotfiles/vim/plugins.vim
" }}}

" Theme {{{
if has('termguicolors')
  set termguicolors
endif

augroup my_colorscheme
  autocmd!
  autocmd ColorScheme * highlight CursorLineNr guifg=#6cb6eb
  autocmd ColorScheme * highlight NormalFloat guifg=#c5cdd9 guibg=#2b2d3a
  autocmd ColorScheme * let g:terminal_ansi_colors[8] = '#333648'
augroup END

let g:edge_style = 'neon'
let g:edge_diagnostic_virtual_text = 'colored'
let g:edge_better_performance = 1

let g:lightline = { 'colorscheme': 'edge' }
silent! colorscheme edge
" }}}

" Backup/Swp/Undo {{{
call mkdir($HOME . "/.undo", "p")
call mkdir($HOME . "/.backup", "p")
call mkdir($HOME . "/.swp", "p")

set undodir=$HOME/.undo
set backupdir=$HOME/.backup
set directory=$HOME/.swp
" }}}

" SpellCheck {{{
augroup my_spell
  autocmd!
  autocmd BufRead,BufNewFile *.md setlocal spell
augroup END
" }}}

" Custom FileTypes {{{
augroup my_filetypes
  autocmd!
  autocmd BufRead,BufNewFile *.graphql set filetype=graphql
  autocmd BufRead,BufNewFile Brewfile* set filetype=ruby
augroup END
" }}}

" ColorColumn {{{
augroup my_colorcolumn
  autocmd!
  autocmd BufRead,BufNewFile *.lua set colorcolumn=120
augroup END
" }}}

" Folds {{{
augroup my_folds
  autocmd!
  autocmd FileType lua,sh,vim setlocal foldmethod=marker
augroup END
set foldlevel=99 " Start folds expanded by default
" }}}

" Windows {{{
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

command! -nargs=* T botright split | terminal <args>
command! -nargs=* VT botright vsplit | terminal <args>
" }}}

" Spaces & Tabs {{{
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab " tabs are spaces
set list listchars=tab:\ \ ,trail:· " Add dots for spacing
" }}}

" Comments {{{
augroup my_comments
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " don't auto-comment
  autocmd FileType json syntax match Comment +\/\/.\+$+ " highlight comments in JSON
augroup END
" }}}

" General {{{
set hidden
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
set splitright " make vertical splits open on right
set splitbelow " make horizontal splits open on botom
set timeoutlen=1000 ttimeoutlen=10 " speed up switch between modes
set updatetime=100 " allow GitGutter to update almost instantly
set diffopt+=vertical

set signcolumn=yes
" }}}

" Searching {{{
set nohlsearch
set incsearch " search as characters are entered
set ignorecase " use case insensitive search
set smartcase " don't use insensitive search when using capital letters
set path+=** " recursively search path
" }}}
