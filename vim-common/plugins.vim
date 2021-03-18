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

" Appearance {{{
Plug 'tyrannicaltoucan/vim-quantum'

Plug 'mhinz/vim-startify'

Plug 'itchyny/lightline.vim'
if g:use_builtin_lsp
  Plug 'spywhere/lightline-lsp'
else
  Plug 'josa42/vim-lightline-coc'
endif
" }}}

" Brackets {{{
Plug 'jackieaskins/vim-closer'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-endwise'
Plug 'andymass/vim-matchup'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-surround'
" }}}

" Editing {{{
Plug 'tpope/vim-abolish'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-repeat'

if g:use_builtin_lsp
  Plug 'hrsh7th/vim-vsnip'
endif

if has('nvim-0.5')
  Plug 'mhartington/formatter.nvim'
endif
" }}}

" File Navigation {{{
" File explorer
if has('nvim-0.5')
  Plug 'kyazdani42/nvim-tree.lua'
else
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
end

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" }}}

" Git {{{
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" }}}

" LSP {{{
if g:use_builtin_lsp
  Plug 'neovim/nvim-lspconfig'
  Plug 'alexaandru/nvim-lspupdate'
  Plug 'jackieaskins/lsp-status.nvim'
  Plug 'glepnir/lspsaga.nvim'
  Plug 'hrsh7th/nvim-compe'
  Plug 'kosayoda/nvim-lightbulb'
  Plug 'mfussenegger/nvim-jdtls'
else
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
endif
" }}}

" Movement {{{
Plug 'szw/vim-maximizer'
Plug 'matze/vim-move'
" }}}

" Syntax {{{
if g:use_treesitter
  Plug 'tpope/vim-sleuth'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
else
  Plug 'uiiaoo/java-syntax.vim'
  Plug 'sheerun/vim-polyglot' " Polyglot needs to go after other syntax plugins
endif
" }}}

" Testing {{{
Plug 'vim-test/vim-test'
" }}}

" DevIcons {{{
if has('nvim-0.5')
  Plug 'kyazdani42/nvim-web-devicons'
else
  Plug 'ryanoasis/vim-devicons' " Needs to be last plugin
end
" }}}

call plug#end()
