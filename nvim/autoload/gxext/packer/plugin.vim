const s:pattern = '\.*\([a-zA-Z0-9_.-]\+\/[a-zA-Z0-9_.-]\+\)'

function! gxext#packer#plugin#open(line, mode)
  let l:line = a:line
  if a:mode ==# 'normal'
    let l:line = getline('.')
    let l:col = col('.') - 1
    let l:line = gxext#matchstr_around(l:line, s:pattern, l:col)
  endif

  echom l:line

  let l:match = matchlist(l:line, s:pattern)
  if empty(l:match)
    return 0
  endif

  call gxext#browse('https://github.com/' . l:match[1])
  return 1
endfunction
