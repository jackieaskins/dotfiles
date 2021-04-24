" Settings {{{
set nocompatible
set encoding=utf8

" Leader key
nnoremap <Space> <nop>
let mapleader = " "

let g:vimsyn_embed = 'lPr'

" Reload Vim
nnoremap <Leader>re :source $MYVIMRC<CR>

" SpellCheck
autocmd BufRead,BufNewFile *.md setlocal spell

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

let g:onedark_color_overrides = {
      \ 'black': { 'gui': '#1E1E1E', 'cterm': '234', 'cterm16': '0' },
      \ }
let g:lightline = { 'colorscheme': 'onedark' }
colorscheme onedark
" }}}

" Backup/Swp/Undo {{{
call mkdir($HOME . "/.undo", "p")
call mkdir($HOME . "/.backup", "p")
call mkdir($HOME . "/.swp", "p")

set undodir=$HOME/.undo
set backupdir=$HOME/.backup
set directory=$HOME/.swp
" }}}

" Folds {{{
autocmd FileType lua,sh,vim setlocal foldmethod=marker
highlight Folded guifg=PeachPuff4
set foldlevel=99 " Start folds expanded by default
set foldcolumn=2 " Show fold column with width 2
" }}}

" Windows {{{
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

command! -nargs=* T botright split | terminal <args>
command! -nargs=* VT botright vsplit | terminal <args>
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

set signcolumn=yes
" }}}

" Mappings {{{
function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!open '".s:uri."'"
    :redraw!
  endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>
nnoremap <Leader>{ i{<CR>return <Esc>$%o};<Esc>^=i{
" }}}

" Searching {{{
set nohlsearch
set incsearch " search as characters are entered
set ignorecase " use case insensitive search
set smartcase " don't use insensitive search when using capital letters
set path+=** " recursively search path
" }}}
