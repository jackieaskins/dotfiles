" Vundle setup
set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"" Themes
Plugin 'tyrannicaltoucan/vim-quantum'
" One Dark - **Current**
Plugin 'joshdick/onedark.vim'
" One Half
Plugin 'sonph/onehalf', { 'rtp': 'vim/' }
" PaperColor
Plugin 'NLKNguyen/papercolor-theme'

"" Plugins
" Airline - Customize status/tabline
" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
" ALE - Asynchronous syntax checking
Plugin 'w0rp/ale'
" Commentary - Easily insert comments
Plugin 'tpope/vim-commentary'
" CSS Color - Preview colors in code
Plugin 'ap/vim-css-color'
" CSS3 Syntax
Plugin 'hail2u/vim-css3-syntax'
" CtrlP - Fuzzy file search
Plugin 'kien/ctrlp.vim'
" Easy Dir - Allow creating directories
Plugin 'duggiefresh/vim-easydir'
" Endwise - Add end keywords
Plugin 'tpope/vim-endwise'
" Emmet
Plugin 'mattn/emmet-vim'
" Eunuch - UNIX commands in Vim
Plugin 'tpope/vim-eunuch'
" Fugitive - Git integration in Vim
Plugin 'tpope/vim-fugitive'
" GitGutter
Plugin 'airblade/vim-gitgutter.git'
" Gundo - Vim undo tree
Plugin 'sjl/gundo.vim'
" Lightline - Customize status/tabline
Plugin 'itchyny/lightline.vim'
" Lightline Ale
Plugin 'maximbaz/lightline-ale'
" Markdown Preview
Plugin 'JamshedVesuna/vim-markdown-preview'
" MatchIt - Extended bracket matching with %
Plugin 'adelarsq/vim-matchit'
" NerdTree - Visual file tree
Plugin 'scrooloose/nerdtree'
" NerdTree Git Plugin
Plugin 'Xuyuanp/nerdtree-git-plugin'
" Polyglot - All-in-one Syntax
Plugin 'sheerun/vim-polyglot'
" Rails - Commands for working with Rails
Plugin 'tpope/vim-rails'
" Repeat - Remap . command to do more
Plugin 'tpope/vim-repeat'
" Snipmate - Language specific snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
" Splitjoin - Split/join single/multi-line statements
Plugin 'AndrewRadev/splitjoin.vim'
" Surround - Surround in brackets/quotes
Plugin 'tpope/vim-surround'
" Trailing Whitespace
Plugin 'bronson/vim-trailing-whitespace'

call vundle#end()            " required
filetype plugin indent on    " required
