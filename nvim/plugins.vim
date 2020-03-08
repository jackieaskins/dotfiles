call plug#begin('~/.local/share/nvim/plugged')

"" Theme
" Quantum
Plug 'tyrannicaltoucan/vim-quantum'

"" Plugins
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
" GutenTags
Plug 'ludovicchabant/vim-gutentags'
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
" UltiSnips - Language-specific snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Vista - View LSP symbols and tags
Plug 'liuchengxu/vista.vim'

call plug#end()
