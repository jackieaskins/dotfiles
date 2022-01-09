const s:pattern = '^\s*"\(\S\+\)"'

function! gxext#json#package#open(line, mode)
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

  echo (l:match[1])

  call gxext#browse('https://npmjs.com/package/' . l:match[1])
  return 1
endfunction
