function! StartifyEntryFormat()
  return 'nerdfont#find(absolute_path) . " " . entry_path'
endfunction

let g:startify_change_to_dir = 0
let g:startify_custom_indices = map(range(0, 100), 'v:val < 10 ? 0 . string(v:val) : string(v:val)')
let g:startify_lists = [
      \ { 'type': 'dir',       'header': [ '   MRU in ' . getcwd() ] },
      \ { 'type': 'files',     'header': [ '   MRU'                ] },
      \ { 'type': 'sessions',  'header': [ '   Sessions'           ] },
      \ { 'type': 'bookmarks', 'header': [ '   Bookmarks'          ] },
      \ { 'type': 'commands',  'header': [ '   Commands'           ] },
      \ ]
