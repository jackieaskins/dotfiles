const s:pattern = '^\s\+\(\x\{7}\)\s.*\(.*\)$'

function! gxext#packer#commit#open(line, mode)
  let l:line = a:line
  if a:mode ==# 'normal'
    let l:line = getline('.')
    let l:col = col('.') - 1
    let l:line = gxext#matchstr_around(l:line, s:pattern, l:col)
  endif

  let l:match = matchlist(l:line, s:pattern)

  if empty(l:match)
    return 0
  endif

  let l:commit_hash = l:match[1]
  let l:line_nr = line('.') - 1

  while l:line_nr > 3
    let l:line = getline(l:line_nr)
    let l:matchlist = matchlist(l:line, 'URL:\s\(\S\+\)')

    if len(l:matchlist) > 0
      call gxext#browse(l:matchlist[1] . '/commit/' . l:commit_hash)
      return 1
    endif

    let l:line_nr = l:line_nr - 1
  endwhile

  return 0
endfunction
