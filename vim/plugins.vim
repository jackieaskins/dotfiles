" Auto-install vim-plug {{{
let autoload_plug_path = '~/.vim/autoload/plug.vim'

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

call plug#begin('~/.vim/plugged')

" Appearance {{{
Plug 'tyrannicaltoucan/vim-quantum'

Plug 'mhinz/vim-startify'

Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'

Plug 'itchyny/lightline.vim'
Plug 'spywhere/lightline-lsp'
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
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-repeat'
Plug 'iamcco/markdown-preview.nvim', {
      \ 'do': { -> mkdp#util#install() },
      \ 'for': ['markdown', 'vim-plug']
      \ }
" }}}

" File Navigation {{{
" File explorer
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" }}}

" Git {{{
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" }}}

" Movement {{{
Plug 'easymotion/vim-easymotion'
Plug 'szw/vim-maximizer'
Plug 'matze/vim-move'
Plug 'unblevable/quick-scope'
Plug 'tpope/vim-unimpaired'
" }}}

" Syntax {{{
Plug 'uiiaoo/java-syntax.vim'
Plug 'sheerun/vim-polyglot' " Polyglot needs to go after other syntax plugins
" }}}

" Testing {{{
Plug 'vim-test/vim-test'
" }}}

call plug#end()
