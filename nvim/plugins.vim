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

" Fugitive - Git integration
Plug 'tpope/vim-fugitive'

" Lightline - Improved status/tabline
Plug 'itchyny/lightline.vim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'

" NerdCommenter - Comments
Plug 'preservim/nerdcommenter'

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
