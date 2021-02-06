" Theme {{{
if has('termguicolors')
  set termguicolors
endif

let g:lightline = { 'colorscheme': 'quantum' }
let g:quantum_black = 1
colorscheme quantum
" }}}

" Better Whitespace {{{
nnoremap <Leader>sw :StripWhitespace<CR>
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

" Coc {{{
if !g:use_builtin_lsp
  inoremap <silent><expr> <c-space> coc#refresh()
  let g:coc_config_home = '~/dotfiles/vim-common'
  let g:coc_global_extensions = [
        \ 'coc-css',
        \ 'coc-eslint',
        \ 'coc-highlight',
        \ 'coc-html',
        \ 'coc-java',
        \ 'coc-jest',
        \ 'coc-json',
        \ 'coc-marketplace',
        \ 'coc-prettier',
        \ 'coc-python',
        \ 'coc-snippets',
        \ 'coc-solargraph',
        \ 'coc-tsserver',
        \ 'coc-yaml',
        \ ]

  nnoremap <silent> gd <Plug>(coc-definition)
  nnoremap <silent> gy <Plug>(coc-type-definition)
  nnoremap <silent> gi <Plug>(coc-implementation)
  nnoremap <silent> gr <Plug>(coc-references)

  nnoremap <Leader>qf <Plug>(coc-fix-current)
  nnoremap <Leader>rn <Plug>(coc-rename)
  nnoremap <Leader>sy :<C-u>CocList -I symbols<cr>
  nnoremap <Leader>d :<C-u>CocList diagnostics<cr>

  " Use `[g` and `]g` to navigate diagnostics
  nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
  nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  "" coc-eslint
  nnoremap <Leader>ef :CocCommand eslint.executeAutofix<CR>

  "" coc-jest
  command! -nargs=0 J :call CocAction('runCommand', 'jest.projectTest')
  command! -nargs=0 JC :call CocAction('runCommand', 'jest.fileTest', ['%'])
  nnoremap <Leader>jt :call CocAction('runCommand', 'jest.singleTest')<CR>

  "" coc-snippets
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? coc#_select_confirm() :
        \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()

  "" coc-tsserver
  nnoremap <Leader>tf :CocCommand tsserver.executeAutofix<CR>

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  let g:coc_snippet_next = '<tab>'
endif
" }}}

" Commentary {{{
autocmd FileType json setlocal commentstring=\/\/\ %s
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

" FZF {{{
if !g:use_builtin_lsp
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
  nnoremap <Leader>/ :Rg<Space>
  nnoremap <Leader>rg :Rg<CR>
  nnoremap <Leader>f :Rg<Space><C-r><C-w><CR>
  nnoremap <Leader>gs :GFiles?<CR>
endif
" }}}

" Java Syntax {{{
highlight link JavaIdentifier NONE
" }}}

" Lightline {{{
let s:error_indicator = ' '
let s:warning_indicator = ' '
let s:info_indicator = '🛈 '
let s:hint_indicator = '! '
let s:ok_indicator = ''

if g:use_builtin_lsp
  let g:lightline#lsp#indicator_errors = s:error_indicator
  let g:lightline#lsp#indicator_warnings = s:warning_indicator
  let g:lightline#lsp#indicator_infos = s:info_indicator
  let g:lightline#lsp#indicator_hints = s:hint_indicator
  let g:lightline#lsp#indicator_ok = s:ok_indicator
else
  let g:lightline#coc#indicator_errors = s:error_indicator
  let g:lightline#coc#indicator_warnings = s:warning_indicator
  let g:lightline#coc#indicator_info = s:info_indicator
  let g:lightline#coc#indicator_hints = s:hint_indicator
  let g:lightline#coc#indicator_ok = s:ok_indicator
endif

function! LightlineLspStatus()
  if g:use_builtin_lsp
    return luaeval("require'lsp-statusline'.get_status()")
  endif

  return get(g:, 'coc_status', '')
endfunction

function! LightlineFilename()
  "" vim-common/config.vim -> v/config.vim
  return expand('%:t') !=# '' ? pathshorten(fnamemodify(expand('%'), ':~:.')) : '[No Name]'
endfunction

function! LightlineTabFilename(n)
  "" vim-common/config.vim -> v/config.vim
  let bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  let bufFiletype = getbufvar(bufnr, '&filetype')

  if bufFiletype == 'fzf'
    return '[FZF]'
  endif

  return expand('#' . bufnr . ':t') !=# '' ? pathshorten(fnamemodify(expand('#' . bufnr), ':~:.')) : '[No Name]'
endfunction

function! LightlineFiletype()
  return index(['', 'gitcommit'], &filetype) < 0 ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft'
endfunction

let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'readonly', 'filename', 'modified' ],
      \           [ 'lsp_status' ] ],
      \ 'right': [ ['lsp_info', 'lsp_warnings', 'lsp_errors', 'lsp_ok', 'lsp_hints' ],
      \            [ 'lineinfo', 'percent' ],
      \            [ 'filetype' ] ]
      \ }
let g:lightline.inactive = {
      \ 'left': [ [ 'filename', 'modified' ] ],
      \ 'right': [ [ 'lineinfo', 'percent' ] ],
      \ }
let g:lightline.component_function = {
      \ 'filename': 'LightlineFilename',
      \ 'filetype': 'LightlineFiletype',
      \ 'lsp_status': 'LightlineLspStatus',
      \ }
let g:lightline.component_expand = {
      \ 'lsp_errors': g:use_builtin_lsp ? 'lightline#lsp#errors' : 'lightline#coc#errors',
      \ 'lsp_warnings': g:use_builtin_lsp ? 'lightline#lsp#warnings' : 'lightline#coc#warnings',
      \ 'lsp_info': g:use_builtin_lsp ? 'lightline#lsp#infos' : 'lightline#coc#info',
      \ 'lsp_hints': g:use_builtin_lsp ? 'lightline#lsp#hints' : 'lightline#coc#hints',
      \ 'lsp_ok': g:use_builtin_lsp ? 'lightline#lsp#ok' : 'lightline#coc#ok'
      \ }
let g:lightline.component_type = {
      \ 'lsp_warnings': 'warning',
      \ 'lsp_errors': 'error',
      \ 'lsp_info': 'info',
      \ 'lsp_hints': 'hint',
      \ 'lsp_ok': 'left'
      \ }

let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ ] ],
      \ }
let g:lightline.tab_component_function = {
      \ 'filename': 'LightlineTabFilename'
      \ }
let g:lightline.tab = {
      \ 'active': ['tabnum', 'filename', 'modified'],
      \ 'inactive': ['tabnum', 'filename', 'modified']
      \ }
" }}}

" LSP {{{
if g:use_builtin_lsp
  lua require'lsp'
endif
" }}}

" MatchUp {{{
let g:matchup_matchparen_offscreen = { 'method': 'status_manual' }
" }}}

" NerdTree {{{
if !has('nvim-0.5')
  let g:NERDTreeWinSize = 60
  let NERDTreeShowHidden = 1
  let NERDTreeQuitOnOpen = 1
  let NERDTreeIgnore = ['node_modules', '\.git$', '\.DS_Store', 'tags.lock']
  let NERDTreeMinimalUI = 1

  nnoremap <C-n> :NERDTreeToggle<CR>
  nnoremap <Leader>n :NERDTreeFind<CR>
end
" }}}

" Polyglot {{{
"" JSX
let g:jsx_ext_required = 0
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
let g:startify_custom_indices = map(range(0, 100), 'v:val < 10 ? 0 . string(v:val) : string(v:val)')
let g:startify_lists = [
      \ { 'type': 'dir',                      'header': [ '   MRU in ' . getcwd() ] },
      \ { 'type': function('s:gitModified'),  'header': [ '   Git Modified'       ] },
      \ { 'type': function('s:gitUntracked'), 'header': [ '   Git Untracked'      ] },
      \ { 'type': function('s:gitCached'),    'header': [ '   Git Cached'         ] },
      \ { 'type': 'files',                    'header': [ '   MRU'                ] },
      \ { 'type': 'sessions',                 'header': [ '   Sessions'           ] },
      \ { 'type': 'bookmarks',                'header': [ '   Bookmarks'          ] },
      \ { 'type': 'commands',                 'header': [ '   Commands'           ] },
      \ ]
" }}}

" Telescope {{{
if g:use_builtin_lsp

lua << EOF
require('telescope').setup {
  defaults = {
    layout_strategy = 'flex',
    prompt_position = 'top',
    sorting_strategy = 'ascending'
  }
}
EOF

nnoremap <C-p> :lua require'telescope.builtin'.find_files({ find_command = {'rg','--ignore','--hidden','--files'} })<CR>
nnoremap <leader>/ :lua require'telescope.builtin'.live_grep{}<CR>
nnoremap <leader>f :lua require'telescope.builtin'.grep_string{}<CR>
nnoremap <leader>gs :lua require'telescope.builtin'.git_status{}<CR>
nnoremap <silent> gr :lua require'telescope.builtin'.lsp_references{}<CR>
nnoremap <leader>ca :lua require'telescope.builtin'.lsp_code_actions{}<CR>
nnoremap <leader>cr :lua require'telescope.builtin'.lsp_range_code_actions{}<CR>
nnoremap <leader>ht :lua require'telescope.builtin'.help_tags{}<CR>

endif
" }}}

" Tree {{{
if has('nvim-0.5')
  let g:nvim_tree_follow = 1
  let g:nvim_tree_git_hl = 1
  let g:nvim_tree_ignore = ['.git', 'node_modules', '.DS_Store']
  let g:nvim_tree_indent_markers = 1
  let g:nvim_tree_quit_on_open = 1
  let g:nvim_tree_width = 50

  nnoremap <C-n> :NvimTreeToggle<CR>
  nnoremap <Leader>n :NvimTreeFindFile<CR>
end
" }}}
