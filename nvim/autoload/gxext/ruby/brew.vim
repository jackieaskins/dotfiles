const s:pattern = '\s*\(brew\|cask\)\s\+''\([a-zA-Z0-9_.-]\+\)'''

function! gxext#ruby#brew#open(line, mode)
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

  let l:path = l:match[1] ==# 'brew' ? 'formula/' : 'cask/'
  call gxext#browse('https://formulae.brew.sh/' . l:path . l:match[2] . '#default')
  return 1
endfunction
