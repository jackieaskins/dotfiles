source ~/.config/nvim/plugins.vim

if !empty(glob("~/.config/nvim/custom.vim"))
  source ~/.config/nvim/custom.vim
endif

" Theme
if has('termguicolors')
  set termguicolors
endif

let g:lightline = { 'colorscheme': 'quantum' }
let g:quantum_black = 1
colorscheme quantum

" Spaces & Tabs
set shiftwidth=2
set tabstop=2 " number of visual spaces per <TAB>
set softtabstop=2 " number of spaces in tab when editing
set expandtab " tabs are spaces
set list listchars=tab:\ \ ,trail:· " Add dots for spacing

" UI Config
set showtabline=2 " always display tabline
set number " show line number
set relativenumber " show line numbers relative to the current line
set cursorline " highlight current line
set showmatch " highlight matching bracket
set confirm " raise a dialog asking if you want to save changes when exiting
set splitright " make vertical splits open on right
set splitbelow " make horizontal splits open on botom
set timeoutlen=1000 ttimeoutlen=10 " speed up switch between modes
set updatetime=100 " allow GitGutter to update almost instantly
set diffopt+=vertical
set nohlsearch

if exists('&signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" Searching
set ignorecase " use case insensitive search
set smartcase " don't use insensitive search when using capital letters

" Windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"" Plugins
" Ack
let g:ackprg = 'ag --nogroup --nocolor --column' " Use Ag for searching with Ack

" ALE
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint', 'tsserver']
      \}

" Better Whitespace
let g:better_whitespace_guicolor = '#dd7186'
command! SW StripWhitespace

" Closetag
let g:closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx'
let g:closetag_xhtml_filenames = '*.js,*.jsx,*.ts,*.tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_close_shortcut = '<leader>>'

" Deoplete
let g:deoplete#enable_at_startup = 1

" Emmet
let g:user_emmet_leader_key = '<leader>m'
let g:user_emmet_settings = {
      \  'javascript' : {
      \      'extends' : 'jsx',
      \  },
      \  'javascript.jsx' : {
      \      'extends' : 'jsx',
      \  },
      \  'typescript' : {
      \      'extends' : 'jsx',
      \  },
      \  'typescript.jsx' : {
      \      'extends' : 'jsx',
      \  },
      \}

" FZF
" Make FZF behave more like Ctrl-P
nnoremap <c-p> :FZF<cr>
augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler norelativenumber nonumber
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler relativenumber number
augroup END

" Istanbul
let g:istanbul#jsonPath = ['coverage/coverage-final.json']
command! IU IstanbulUpdate
command! IT IstanbulToggle

" JSX
let g:jsx_ext_required = 0

" Lightline
let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'fugitive', 'readonly', 'filename' ] ],
      \ 'right': [ [ 'linter_errors', 'linter_warnings', 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_function = {
      \ 'filename': 'LightlineFilename',
      \ 'fugitive': 'fugitive#head'
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ ] ],
      \ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

" Markdown Preview
let vim_markdown_preview_toggle = 1
let vim_markdown_preview_hotkey = '<C-m>'
let vim_markdown_preview_github = 1
let vim_markdown_preview_browser = 'Google Chrome'
let vim_markdown_preview_temp_file = 1

" NerdTree
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore = ['node_modules', '\.git$', '\.DS_Store', 'tags.lock']
map <C-n> :NERDTreeToggle<CR>

" Plug
command! PI PlugInstall
command! PU PlugUpgrade | PlugUpdate
command! PC PlugClean

" SplitJoin
let g:splitjoin_html_attributes_bracket_on_new_line = 1
nmap gj gJ=%
nmap gs gS=%
nmap gps %r}<C-O>r{oreturn (<ESC>k$%O);<ESC>h=%

" Tagbar
command! TT TagbarToggle

" UltiSnips
let g:UltiSnipsJumpForwardTrigger = '<leader>n'
let g:UltiSnipsJumpBackwardTrigger = '<leader>p'