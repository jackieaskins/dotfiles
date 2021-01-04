" Auto-install vim-plug
let autoload_plug_path = has('nvim') ? '~/.local/share/nvim/site/autoload/plug.vim' : '~/.vim/autoload/plug.vim'

if empty(glob(autoload_plug_path))
  silent execute '!curl -fLo ' . autoload_plug_path . ' --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'

  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Open plugin in GitHub
nnoremap <Leader>gh yi':!open https://github.com/<C-R>0<CR><CR>

call plug#begin(has('nvim') ? '~/.local/share/nvim/plugged' : '~/.vim/plugged')

"" Theme
" Quantum
Plug 'tyrannicaltoucan/vim-quantum'

"" Plugins
" Abolish - Improved search, substitute, and abbreviate
Plug 'tpope/vim-abolish'
" Better Whitespace
Plug 'ntpeters/vim-better-whitespace'
" Closer - Autoclose braces on enter
Plug 'jackieaskins/vim-closer'
" CloseTag - Autoclose HTML tags
Plug 'alvan/vim-closetag'
" CoC - Intellisense
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" Commentary
Plug 'tpope/vim-commentary'
" Easymotion
Plug 'easymotion/vim-easymotion'
" Emmet
Plug 'mattn/emmet-vim'
" Endwise - Add end keywords
Plug 'tpope/vim-endwise'
" Fugitive - Git integration in Vim
Plug 'tpope/vim-fugitive'
" FZF - Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" GitGutter
Plug 'airblade/vim-gitgutter'
" Java Syntax
Plug 'uiiaoo/java-syntax.vim'
" Lightline - Customize status/tabline
Plug 'itchyny/lightline.vim'
" Lightline-Coc - Lightline Coc integraiton
Plug 'josa42/vim-lightline-coc'
" MatchUp - Extend bracket matching with %
Plug 'andymass/vim-matchup'
" Move
Plug 'matze/vim-move'
" NerdTree - Visual file tree
Plug 'scrooloose/nerdtree'
" NerdTree Git Plugin
Plug 'Xuyuanp/nerdtree-git-plugin'
" Repeat - Remap . command to do more
Plug 'tpope/vim-repeat'
" Splitjoin - Split/join single/multi-line statements
Plug 'AndrewRadev/splitjoin.vim'
" Startify - Customized startup screen
Plug 'mhinz/vim-startify'
" Surround - Surround in brackets/quotes
Plug 'tpope/vim-surround'

" Polyglot - All-in-one Syntax
Plug 'sheerun/vim-polyglot'
" DevIcons
Plug 'ryanoasis/vim-devicons'

call plug#end()
