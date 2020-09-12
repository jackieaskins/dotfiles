" Auto-install vim-plug {{{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Mappings for plugin management
command! PI PlugInstall
command! PU PlugUpgrade | PlugUpdate
command! PC PlugClean
command! PD PlugDiff
" }}}

" Open plugin in GitHub
nnoremap <Leader>gh yi':!open https://github.com/<C-R>0<CR><CR>

call plug#begin('~/.local/share/nvim/plugged')

" Theme
Plug 'tyrannicaltoucan/vim-quantum'

" Better Whitespace
Plug 'ntpeters/vim-better-whitespace'
" Closer - Autoclose braces on enter
Plug 'jackieaskins/vim-closer'
" CloseTag - Autoclose HTML tags
Plug 'alvan/vim-closetag'
" Commandline Complete
Plug 'j5shi/CommandlineComplete.vim'
" Easymotion
Plug 'easymotion/vim-easymotion'
" Emmet
Plug 'mattn/emmet-vim'
" Endwise - Add end keywords
Plug 'tpope/vim-endwise'
" Fugitive - Git integration
Plug 'tpope/vim-fugitive'
" GitGutter
Plug 'airblade/vim-gitgutter'
" Lightline - Improved status/tabline
Plug 'itchyny/lightline.vim'
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-lua/lsp-status.nvim'
" Markdown Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" MatchUp - Extend bracket matching with %
Plug 'andymass/vim-matchup'
" Move
Plug 'matze/vim-move'
" NerdCommenter - Comments
Plug 'preservim/nerdcommenter'
" Repeat - Remap . command to do more
Plug 'tpope/vim-repeat'
" Scalpel - Better substitions
Plug 'wincent/scalpel'
" Splitjoin - Split/join single/multi-line statements
Plug 'AndrewRadev/splitjoin.vim'
" Startify - Customized startup screen
Plug 'mhinz/vim-startify'
" Telescope - Fuzzy finding
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
" Treesitter - Syntax highlighting and other utils
Plug 'nvim-treesitter/nvim-treesitter'

" DevIcons
Plug 'ryanoasis/vim-devicons'

call plug#end()
