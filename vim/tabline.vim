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
    " if tabpagenr('$') > 1
    "   let s .= '%=%#TabLine#%999XX'
    " endif
    return s
  endfunction
  set showtabline=2 " Always show the tabline
  set tabline=%!MyTabLine()
endif
