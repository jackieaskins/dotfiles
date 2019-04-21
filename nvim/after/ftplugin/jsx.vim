if exists("loaded_matchit")
  let b:match_ignorecase = 0
  let b:match_skip = 'synIDattr(synID(line("."),col("."),1),"name")
        \ =~? "jsComment\\|jsString\\|jsArrowFunction"'
  let b:match_words = '(:),\[:\],{:},<:>,' .
        \ '<\@<=\([^/][^ \t>]*\)\%(/\@<!>\|$\|[ \t][^>]*\%(/\@<!>\|$\)\):<\@<=/\1>'
endif
