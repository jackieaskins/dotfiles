call plug#begin('~/.local/share/nvim/plugged')

"" Theme
" Quantum - **Current**
Plug 'tyrannicaltoucan/vim-quantum'

"" Plugins
" Better Whitespace
Plug 'ntpeters/vim-better-whitespace'
" Closer - Autoclose braces on enter
Plug 'rstacruz/vim-closer'
" CloseTag - Autoclose HTML tags
Plug 'alvan/vim-closetag'
" CoC - Intellisense
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" Commentary - Easily insert comments
Plug 'tpope/vim-commentary'
" CSS3 Syntax
Plug 'hail2u/vim-css3-syntax'
" Ctrlsf - Mimick Sublime Text Cmd-Shift-F
Plug 'dyng/ctrlsf.vim'
" Easymotion
Plug 'easymotion/vim-easymotion'
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
" Markdown Preview
Plug 'JamshedVesuna/vim-markdown-preview'
" MatchIt - Extended bracket matching with %
Plug 'adelarsq/vim-matchit'
" NerdTree - Visual file tree
Plug 'scrooloose/nerdtree'
" NerdTree Git Plugin
Plug 'Xuyuanp/nerdtree-git-plugin'
" Polyglot - All-in-one Syntax
Plug 'sheerun/vim-polyglot'
" Repeat - Remap . command to do more
Plug 'tpope/vim-repeat'
" Splitjoin - Split/join single/multi-line statements
Plug 'AndrewRadev/splitjoin.vim'
" Surround - Surround in brackets/quotes
Plug 'tpope/vim-surround'
" Startify - Customized startup screen
Plug 'mhinz/vim-startify'
" Tagbar - View tags in sidebar
Plug 'majutsushi/tagbar'
" UltiSnips - Language-specific snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()
