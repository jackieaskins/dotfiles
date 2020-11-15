" Theme {{{
set termguicolors
set background=dark
let g:quantum_black = 1
silent! colorscheme quantum " Don't complain if colorscheme isn't installed yet
" }}}

" Better Whitespace {{{
command! SW StripWhitespace
let g:better_whitespace_guicolor = '#dd7186'
let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown']
" }}}

" Closetag {{{
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
" }}}

" Emmet {{{
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
" }}}

" Lightline {{{
let g:lightline = { 'colorscheme': 'quantum' }

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

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
      \           [ 'lsp_status' ] ],
      \ 'right': [ [ ],
      \            [ 'lineinfo', 'percent' ],
      \            [ 'filetype' ] ]
      \ }
let g:lightline.component_function = {
      \ 'filename': 'LightlineFilename',
      \ 'fugitive': 'LightlineBranch',
      \ 'filetype': 'LightlineFiletype',
      \ 'lsp_status': 'LspStatus'
      \ }
let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ ] ],
      \ }
" }}}

" LSP {{{
" Completion
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
set shortmess+=c " avoid showing extra message when using completion
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Diagnostic
let g:diagnostic_enable_virtual_text = 1

nnoremap [g        <cmd>PrevDiagnosticCycle<CR>
nnoremap ]g        <cmd>NextDiagnosticCycle<CR>
nnoremap <leader>d <cmd>OpenDiagnostic<CR>

" Commands
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gy    <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
" }}}

" Markdown Preview {{{
nmap <C-m> <Plug>MarkdownPreview
" }}}

" MatchUp {{{
let g:matchup_matchparen_offscreen = { 'method': 'status_manual' }
" }}}

" NerdCommenter {{{
let g:NERDSpaceDelims = 1 " Add space after comment
let g:NERDDefaultAlign = 'left'
" }}}

" Polyglot {{{
"" JSX
let g:jsx_ext_required = 0
" }}}

" Scalpel {{{
nmap <Leader>es <Plug>(Scalpel)
" }}}

" SplitJoin {{{
let g:splitjoin_html_attributes_bracket_on_new_line = 1
" }}}

" Startify {{{
function! MapFiles(files)
  return map(a:files, "{'line': WebDevIconsGetFileTypeSymbol(v:val) . ' ' . v:val, 'path': v:val}")
endfunction

function! s:gitCached()
  let files = systemlist('git diff --cached --name-only 2>/dev/null')
  return MapFiles(files)
endfunction

function! s:gitModified()
  let files = systemlist('git ls-files -m 2>/dev/null')
  return MapFiles(files)
endfunction

function! s:gitUntracked()
  let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
  return MapFiles(files)
endfunction

let g:startify_change_to_dir = 0
let g:startify_lists = [
      \ { 'type': 'dir',                      'header': [ '   MRU in ' . getcwd() ] },
      \ { 'type': function('s:gitModified'),  'header': [ '   Git Modified'       ] },
      \ { 'type': function('s:gitUntracked'), 'header': [ '   Git Untracked'      ] },
      \ { 'type': function('s:gitCached'),    'header': [ '   Git Cached'        ] },
      \ { 'type': 'files',                    'header': [ '   MRU'                ] },
      \ { 'type': 'sessions',                 'header': [ '   Sessions'           ] },
      \ { 'type': 'bookmarks',                'header': [ '   Bookmarks'          ] },
      \ { 'type': 'commands',                 'header': [ '   Commands'           ] },
      \ ]
" }}}

" Telescope {{{
" Files
nnoremap <C-p> :lua require'telescope.builtin'.find_files{}<CR>

" Text searching
nnoremap <Leader>a :lua require'telescope.builtin'.live_grep{}<CR>
nnoremap <Leader>f :lua require'telescope.builtin'.grep_string{ search = <C-r><C-w> }<CR>

" LSP
nnoremap <silent> gr :lua require'telescope.builtin'.lsp_references{}<CR>
nnoremap <Leader>sd :lua require'telescope.builtin'.lsp_document_symbols{}<CR>
nnoremap <Leader>sw :lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>

" Quickfix/LocationList
nnoremap <Leader>qf :lua require'telescope.builtin'.quickfix{}<CR>
nnoremap <Leader>ll :lua require'telescope.builtin'.loclist{}<CR>

" Fallback
nnoremap <Leader>tb :lua require'telescope.builtin'.builtin{}<CR>
" }}}