call plug#begin('~/.local/share/nvim/plugged')

"" Themes
" Ayu
" Plug 'ayu-theme/ayu-vim'
" PaperColor
" Plug 'NLKNguyen/papercolor-theme'
" Quantum - **Current**
Plug 'tyrannicaltoucan/vim-quantum'

"" Plugins
" Ack - Better searching
Plug 'mileszs/ack.vim'
" ALE - Asynchronous syntax checking
Plug 'w0rp/ale'
" Better Whitespace
Plug 'ntpeters/vim-better-whitespace'
" Closer - Autoclose braces on enter
Plug 'rstacruz/vim-closer'
" CloseTag - Autoclose HTML tags
Plug 'alvan/vim-closetag'
" Commentary - Easily insert comments
Plug 'tpope/vim-commentary'
" CSS3 Syntax
Plug 'hail2u/vim-css3-syntax'
" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" Plug 'wokalski/autocomplete-flow'
" Emmet
Plug 'mattn/emmet-vim'
" Endwise - Add end keywords
Plug 'tpope/vim-endwise'
" Eunuch - UNIX commands in Vim
Plug 'tpope/vim-eunuch'
" Fugitive - Git integration in Vim
Plug 'tpope/vim-fugitive'
" FZF - Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" GitGutter
Plug 'airblade/vim-gitgutter'
" Gutentags - Improving Ctags experience
Plug 'ludovicchabant/vim-gutentags'
" Istanbul - Javascript Code Coverage
Plug 'retorillo/istanbul.vim'
" Lightline - Customize status/tabline
Plug 'itchyny/lightline.vim'
" Lightline Ale - Lightline support for Ale
Plug 'maximbaz/lightline-ale'
" Markdown Preview
Plug 'JamshedVesuna/vim-markdown-preview'
" MatchIt - Extended bracket matching with %
Plug 'adelarsq/vim-matchit'
" NerdTree - Visual file tree
Plug 'scrooloose/nerdtree'
" NerdTree Git Plugin
Plug 'Xuyuanp/nerdtree-git-plugin'
" Neosnippet
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" Polyglot - All-in-one Syntax
Plug 'sheerun/vim-polyglot'
" Repeat - Remap . command to do more
Plug 'tpope/vim-repeat'
" Splitjoin - Split/join single/multi-line statements
Plug 'AndrewRadev/splitjoin.vim'
" Tagbar - View tags in sidebar
Plug 'majutsushi/tagbar'
" Surround - Surround in brackets/quotes
Plug 'tpope/vim-surround'

call plug#end()
