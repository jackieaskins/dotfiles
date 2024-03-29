let g:test#strategy = 'vimterminal'
let g:test#vim#term_position = 'vert botright'

let g:test#java#runner = 'gradletest'
let g:test#javascript#jest#options = '--watch'

nmap <leader>tn :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tv :TestVisit<CR>
