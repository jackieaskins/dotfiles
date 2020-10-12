source ~/dotfiles/vim-common/plugins.vim

let g:node_host_prog = '/usr/local/bin/neovim-node-host'

set encoding=utf8

" Set space as Leader key
nnoremap <Space> <nop>
let mapleader = " "

" Reload Vim
nnoremap <Leader>re :source $MYVIMRC<CR>

" Backup/Swp/Undo dirs
if !has('nvim')
  mkdir($HOME . "/.undo", "p")
  mkdir($HOME . "/.backup", "p")
  mkdir($HOME . "/.swp", "p")

  set undodir=$HOME/.undo
  set backupdir=$HOME/.backup
  set directory=$HOME/.swp
end

" Load custom settings
if !empty(glob("~/dotfiles/vim-common/custom.vim"))
  source ~/dotfiles/vim-common/custom.vim
endif

" Theme
if has('termguicolors')
  set termguicolors
endif

let g:lightline = { 'colorscheme': 'quantum' }
let g:quantum_black = 1
colorscheme quantum

" Folds
set foldmethod=syntax
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType xml setlocal foldmethod=indent
highlight Folded guifg=PeachPuff4
set foldlevel=99 " Start folds expanded by default
set foldcolumn=2 " Show fold column with width 2

" Spaces & Tabs
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab " tabs are spaces
autocmd FileType cs,java setlocal shiftwidth=4 tabstop=4 softtabstop=4
set list listchars=tab:\ \ ,trail:· " Add dots for spacing

" Comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " don't auto-comment
autocmd FileType json syntax match Comment +\/\/.\+$+ " enable comments in JSON

" SpellCheck
autocmd BufRead,BufNewFile *.md setlocal spell

" UI Config
set laststatus=2 " always display status line
set showtabline=2 " always display tabline
set number " show line number for current line
set relativenumber " show line numbers relative to the current line
set showcmd " show command in bottom bar
set cursorline " highlight current line
set wildmenu " visual autocomple for command menu
set showmatch " highlight matching bracket
set backspace=indent,eol,start " allow backspacing over autoindent, line breaks, and start of insert action
set ruler " display the cursor position on the last line of the screen
set autoindent " keep same indent as line you're currently on
set confirm " raise a dialog asking if you want to save changes when exiting
set splitright " make vertical splits open on right
set splitbelow " make horizontal splits open on botom
set timeoutlen=1000 ttimeoutlen=10 " speed up switch between modes
set updatetime=100 " allow GitGutter to update almost instantly
set diffopt+=vertical

if exists('&signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" Searching
if has('nvim')
  set inccommand=nosplit " show matches when using substitute/replace
endif
set nohlsearch
set incsearch " search as characters are entered
set ignorecase " use case insensitive search
set smartcase " don't use insensitive search when using capital letters
set path+=** " recursively search path

" Windows
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

"" Plugins {{{
" Ale
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ 'javascript': ['eslint']
      \ }
let g:ale_lint_delay = 50
let g:ale_linters = {
      \ 'java': [],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint']
      \ }

" Better Whitespace
command! SW StripWhitespace
let g:better_whitespace_guicolor = '#dd7186'
let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown']

" Closetag
let g:closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx'
let g:closetag_xhtml_filenames = '*.js,*.jsx,*.ts,*.tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_close_shortcut = '\>'
let g:closetag_regions = {
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ 'typescript': 'jsxRegion,tsxRegion',
    \ 'javascript': 'jsxRegion',
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Coc
inoremap <silent><expr> <c-space> coc#refresh()
let g:coc_config_home = '~/dotfiles/vim-common'
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-emmet',
      \ 'coc-highlight',
      \ 'coc-html',
      \ 'coc-jest',
      \ 'coc-marketplace',
      \ 'coc-java',
      \ 'coc-json',
      \ 'coc-prettier',
      \ 'coc-python',
      \ 'coc-snippets',
      \ 'coc-solargraph',
      \ 'coc-styled-components',
      \ 'coc-tsserver',
      \ 'coc-yaml',
      \ ]

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>qf <Plug>(coc-fix-current)

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <Leader>rn <Plug>(coc-rename)
nnoremap <silent> <Leader>s :<C-u>CocList -I symbols<cr>
nnoremap <silent> <Leader>d :<C-u>CocList diagnostics<cr>

"" coc-eslint
nnoremap <Leader>ef :CocCommand eslint.executeAutofix<CR>

"" coc-snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Emmet
let g:user_emmet_leader_key = '\m'
let g:user_emmet_settings = {
      \ 'javascript' : { 'extends' : 'jsx' },
      \ 'javascript.jsx' : { 'extends' : 'jsx', },
      \ 'javascriptreact' : { 'extends' : 'jsx' },
      \ 'typescript' : { 'extends' : 'jsx' },
      \ 'typescript.jsx' : { 'extends' : 'jsx' },
      \ 'typescript.tsx' : { 'extends' : 'jsx' },
      \ 'typescriptreact' : { 'extends': 'jsx' },
      \}

" FZF
let $FZF_DEFAULT_OPTS .= ' --bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-j:page-down,ctrl-k:page-up,ctrl-a:select-all,?:toggle-preview'

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }

if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --layout=reverse'

  function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let row = ((&lines - height) / 2) - 1
    let col = (&columns - width) / 2

    let opts = {
          \ 'relative': 'editor',
          \ 'row': row,
          \ 'col': col,
          \ 'width': width,
          \ 'height': height,
          \ 'style': 'minimal'
          \ }

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]

    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)

    set winhl=Normal:Floating

    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4

    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)

    au BufWipeout <buffer> exe 'bw ' . s:buf
  endfunction

  let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
endif

nnoremap <C-p> :Files<CR>
nnoremap <Leader>a :Rg<Space>
nnoremap <Leader>f :Rg<Space><C-r><C-w><CR>
nnoremap <Leader>gs :GFiles?<CR>

" Istanbul
let g:istanbul#jsonPath = ['coverage/coverage-final.json']
command! IU IstanbulUpdate
command! IT IstanbulToggle

" Java Syntax
highlight link JavaIdentifier NONE

" Lightline
function! LightlineFilename()
  "" vim-common/config.vim -> v/config.vim
  let filename = expand('%:t') !=# '' ? pathshorten(fnamemodify(expand('%'),':~:.')) : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! LightlineFiletype()
  return index(['', 'gitcommit'], &filetype) < 0 ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft'
endfunction

function! LightlineBranch()
  return fugitive#head() !=# '' ? '' . ' ' . fugitive#head() : ''
endfunction

let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'fugitive', 'readonly', 'filename' ],
      \           ['coc_status' ] ],
      \ 'right': [ [ 'coc_errors', 'coc_warnings', 'coc_ok' ],
      \            [ 'lineinfo', 'percent' ],
      \            [ 'filetype' ] ]
      \ }
let g:lightline.component_function = {
      \ 'filename': 'LightlineFilename',
      \ 'fugitive': 'LightlineBranch',
      \ 'filetype': 'LightlineFiletype'
      \ }
let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ ] ],
      \ }

call lightline#coc#register()

" Markdown Preview
nmap <C-m> <Plug>MarkdownPreview

" MatchUp
let g:matchup_matchparen_offscreen = { 'method': 'status_manual' }

" NerdCommenter
let g:NERDSpaceDelims = 1 " Add space after comment
let g:NERDDefaultAlign = 'left'

" NerdTree
let g:NERDTreeWinSize = 60
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore = ['node_modules', '\.git$', '\.DS_Store', 'tags.lock']
let NERDTreeMinimalUI = 1

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <Leader>n :NERDTreeFind<CR>

" Plug
command! PI PlugInstall
command! PU PlugUpgrade | PlugUpdate
command! PC PlugClean

" Polyglot
"" JSX
let g:jsx_ext_required = 0

" Scalpel
nmap <Leader>es <Plug>(Scalpel)

" SplitJoin
let g:splitjoin_html_attributes_bracket_on_new_line = 1

" Startify
function! s:gitStashed()
  let files = systemlist('git diff --cached --name-only 2>/dev/null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitModified()
  let files = systemlist('git ls-files -m 2>/dev/null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitUntracked()
  let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_change_to_dir = 0
let g:startify_lists = [
      \ { 'type': 'dir',                      'header': [ '   MRU in ' . getcwd() ] },
      \ { 'type': function('s:gitModified'),  'header': [ '   Git Modified'       ] },
      \ { 'type': function('s:gitUntracked'), 'header': [ '   Git Untracked'      ] },
      \ { 'type': function('s:gitStashed'),   'header': [ '   Git Stashed'        ] },
      \ { 'type': 'files',                    'header': [ '   MRU'                ] },
      \ { 'type': 'sessions',                 'header': [ '   Sessions'           ] },
      \ { 'type': 'bookmarks',                'header': [ '   Bookmarks'          ] },
      \ { 'type': 'commands',                 'header': [ '   Commands'           ] },
      \ ]

" Vista
nnoremap <Leader>v :Vista!!<CR>
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista#renderer#enable_icon = 0
" }}}
