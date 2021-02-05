" Auto-install vim-plug {{{
let autoload_plug_path = has('nvim') ? '~/.local/share/nvim/site/autoload/plug.vim' : '~/.vim/autoload/plug.vim'

if empty(glob(autoload_plug_path))
  silent execute '!curl -fLo ' . autoload_plug_path . ' --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'

  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

" Plug Mappings {{{
command! PI PlugInstall
command! PU PlugUpgrade | PlugUpdate
command! PC PlugClean
command! PD PlugDiff

" Open plugin in GitHub
nnoremap <Leader>gh yi':!open https://github.com/<C-R>0<CR><CR>
" }}}

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
if !g:use_builtin_lsp
  " CoC - Intellisense
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
endif
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
Plug 'josa42/vim-lightline-coc'
Plug 'spywhere/lightline-lsp'
if g:use_builtin_lsp
  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/lsp-status.nvim'
  Plug 'hrsh7th/nvim-compe'
  Plug 'kosayoda/nvim-lightbulb'
endif
" MatchUp - Extend bracket matching with %
Plug 'andymass/vim-matchup'
" Move
Plug 'matze/vim-move'
if !has('nvim-0.5')
  " NerdTree - Visual file tree
  Plug 'scrooloose/nerdtree'
  " NerdTree Git Plugin
  Plug 'Xuyuanp/nerdtree-git-plugin'
end
" Repeat - Remap . command to do more
Plug 'tpope/vim-repeat'
" Splitjoin - Split/join single/multi-line statements
Plug 'AndrewRadev/splitjoin.vim'
" Startify - Customized startup screen
Plug 'mhinz/vim-startify'
" Surround - Surround in brackets/quotes
Plug 'tpope/vim-surround'
if has('nvim-0.5')
  " Tree - File explorer
  Plug 'kyazdani42/nvim-tree.lua'
end

" Polyglot - All-in-one Syntax
Plug 'sheerun/vim-polyglot'
" DevIcons
Plug 'ryanoasis/vim-devicons'
if has('nvim-0.5')
  Plug 'kyazdani42/nvim-web-devicons' " Used for nvim-tree
end

call plug#end()
