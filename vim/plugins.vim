" Vim-Plug setup
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

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
" Hardtime - Help break bad Vim habits
Plug 'takac/vim-hardtime'
" Istanbul - Javascript Code Coverage
Plug 'retorillo/istanbul.vim'
" Lightline - Customize status/tabline
Plug 'itchyny/lightline.vim'
" Lightline Ale - Lighline support for Ale
Plug 'maximbaz/lightline-ale'
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
" Tagbar - View tags in sidebar
Plug 'majutsushi/tagbar'
" Tern for Vim
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
" Surround - Surround in brackets/quotes
Plug 'tpope/vim-surround'
" UltiSnips - Language-specific snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Custom Plugins
if !empty(glob("~/.vim/custom_plugins.vim"))
  source ~/.vim/custom_plugins.vim
endif

call plug#end()
