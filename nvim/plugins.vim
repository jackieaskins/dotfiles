call plug#begin('~/.local/share/nvim/plugged')

"" Theme
" Quantum
Plug 'tyrannicaltoucan/vim-quantum'

"" Plugins
" Ack - Better searching
Plug 'mileszs/ack.vim'
" ALE - Asynchronous syntax checking
Plug 'dense-analysis/ale'
" Better Whitespace
Plug 'ntpeters/vim-better-whitespace'
" Closer - Autoclose braces on enter
Plug 'jackieaskins/vim-closer'
" CloseTag - Autoclose HTML tags
Plug 'alvan/vim-closetag'
" CoC - Intellisense
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" CssColor - In-line CSS colors
Plug 'ap/vim-css-color'
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
" Istanbul - Javascript Code Coverage
Plug 'retorillo/istanbul.vim'
" Lightline - Customize status/tabline
Plug 'itchyny/lightline.vim'
" Lightline Ale - Lightline support for Ale
Plug 'maximbaz/lightline-ale'
" Markdown Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" MatchUp - Extend bracket matching with %
Plug 'andymass/vim-matchup'
" NerdCommenter
Plug 'preservim/nerdcommenter'
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
" Startify - Customized startup screen
Plug 'mhinz/vim-startify'
" Surround - Surround in brackets/quotes
Plug 'tpope/vim-surround'
" Targets - Add additional targets
Plug 'wellle/targets.vim'
" Vista - View LSP symbols and tags
Plug 'liuchengxu/vista.vim'

call plug#end()
