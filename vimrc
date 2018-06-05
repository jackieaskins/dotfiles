" Load plugins
source ~/.vim/plugins.vim

" Colors
syntax enable " enable syntax processing
set background=dark
colorscheme PaperColor

" File specific
autocmd BufRead,BufNewFile *.md setlocal spell

command! Eroutes e config/routes.rb
command! Vroutes vs config/routes.rb
command! Sroutes sp config/routes.rb

" Spaces & Tabs
set shiftwidth=2
set tabstop=2 " number of visual spaces per <TAB>
set softtabstop=2 " number of spaces in tab when editing
set expandtab " tabs are spaces
set list listchars=tab:\ \ ,trail:· " Add dots for spacing

" UI Config
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
set splitright " Make vertical splits open on right
set splitbelow " Make horizontal splits open on botom

" Searching
set incsearch " search as characters are entered
set ignorecase " use case insensitive search
set smartcase " don't use insensitive search when using capital letters

" Windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"" Plugins
" Airline
set laststatus=2
let g:airline_powerline_fonts = 1

" ALE
let g:ale_linters = { 'javascript': ['eslint', 'prettier'] }
let g:ale_sign_column_always = 1
let g:ale_lint_delay = 1500

" Commentary
autocmd FileType ocaml setlocal commentstring=(*\ %s\ *)

" CtrlP
let g:crtlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git'

" Emmet
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

" Gundo
noremap <F5> :GundoToggle<CR>

" JSX
let g:jsx_ext_required = 0

" Markdown Preview
let vim_markdown_preview_toggle=1
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_github=1
let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_temp_file=1

" NerdTree
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() >= 1 | NERDTree | wincmd p | endif
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Synastic
" let g:syntastic_javascript_checkers = ['eslint', 'jsxhint']
" let g:syntastic_ocaml_checkers = ['merlin']

"" Extras
" Merlin
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute 'set rtp+=' . g:opamshare . '/merlin/vim'

" Tabline Configuration
if exists("+showtabline")
  function! MyTabLine()
    let s = '' " Initialize the tabline to an empty string
    let t = tabpagenr()

    " Loop through each tab page
    for i in range(tabpagenr('$'))
      let tab = i + 1

      " Configure the buffer name
      let winnr = tabpagewinnr(tab)
      let buflist = tabpagebuflist(tab)
      let bufnr = buflist[winnr - 1]
      let bufname = bufname(bufnr)
      let bufname = bufname != '' ? pathshorten(fnamemodify(bufname, ':~:.')) : bufname

      " Determine if the buffer has been modified
      let bufmodified = getbufvar(bufnr, "&mod")

      " Configure tab with number, highlighting, and buffer name
      let s .= '%' . tab . 'T'
      let s .= (tab == t ? '%#TabLineSel#' : '%#TabLine#')
      let s .= ' ' . tab . ' '
      let s .= (bufname != '' ? bufname . ' ' : '[No Name] ')

      " Display [+] if tab has been modified
      if bufmodified
        let s .= '[+] '
      endif
    endfor

    let s .= '%#TabLineFill#%T'
    if tabpagenr('$') > 1
      let s .= '%=%#TabLine#%999XX'
    endif
    return s
  endfunction
  set showtabline=2 " Always show the tabline
  set tabline=%!MyTabLine()
endif
