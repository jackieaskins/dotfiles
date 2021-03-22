if has('nvim')
  let test#strategy = 'neovim'
  let test#neovim#term_position = 'vert botright'
else
  let test#strategy = 'vimterminal'
  let test#vim#term_position = 'vert botright'
endif

let test#java#runner = 'gradletest'
let test#typescript#jest#options = '--no-coverage --watch'
let test#javascript#jest#options = '--no-coverage --watch'

nmap <leader>tn :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tv :TestVisit<CR>
