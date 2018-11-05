" Vundle setup
set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"" Themes
" Ayu
Plugin 'ayu-theme/ayu-vim'
" PaperColor
Plugin 'NLKNguyen/papercolor-theme'
" Quantum - **Current**
Plugin 'tyrannicaltoucan/vim-quantum'

"" Plugins
" Ack - Better searching
Plugin 'mileszs/ack.vim'
" ALE - Asynchronous syntax checking
Plugin 'w0rp/ale'
" Better Whitespace
Plugin 'ntpeters/vim-better-whitespace'
" Closer - Autoclose braces on enter
Plugin 'rstacruz/vim-closer'
" CloseTag - Autoclose HTML tags
" Plugin 'alvan/vim-closetag'
" Commentary - Easily insert comments
Plugin 'tpope/vim-commentary'
" CSS3 Syntax
Plugin 'hail2u/vim-css3-syntax'
" Emmet
Plugin 'mattn/emmet-vim'
" Endwise - Add end keywords
Plugin 'tpope/vim-endwise'
" Eunuch - UNIX commands in Vim
Plugin 'tpope/vim-eunuch'
" Fugitive - Git integration in Vim
Plugin 'tpope/vim-fugitive'
" FZF - Fuzzy Finder
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" GitGutter
Plugin 'airblade/vim-gitgutter'
" Istanbul - Javascript Code Coverage
Plugin 'retorillo/istanbul.vim'
" Lightline - Customize status/tabline
Plugin 'itchyny/lightline.vim'
" Lightline Ale - Lighline support for Ale
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
" Splitjoin - Split/join single/multi-line statements
Plugin 'AndrewRadev/splitjoin.vim'
" Supertab
Plugin 'ervandew/supertab'
" Tern for Vim
Plugin 'ternjs/tern_for_vim'
" Surround - Surround in brackets/quotes
Plugin 'tpope/vim-surround'
" UltiSnips - Language-specific snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Custom Plugins
if !empty(glob("~/.vim/custom_plugins.vim"))
  source ~/.vim/custom_plugins.vim
endif

call vundle#end()            " required
filetype plugin indent on    " required
