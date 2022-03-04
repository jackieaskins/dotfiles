
"--------------------------------------------------------------------"
"                   onenord lightline colorscheme                    "
"              Extracted from onenord.nvim by rmehri01               "
"              https://github.com/rmehri01/onenord.nvim              "
"--------------------------------------------------------------------"

let s:p = {'normal': {}, 'insert': {}, 'command': {}, 'visual': {}, 'replace': {}, 'inactive': {}, 'tabline': {}}

let s:p.command.left = [ [ '#2E3440', '#EBCB8B' ], [ '#EBCB8B', '#3F4758' ] ]
let s:p.command.middle = [ [ '#6C7A96', '#353B49' ] ]
let s:p.command.right = [ [ '#2E3440', '#EBCB8B' ], [ '#EBCB8B', '#3F4758' ] ]

let s:p.inactive.left = [ [ '#6C7A96', '#3B4252' ], [ '#6C7A96', '#3B4252' ], [ '#6C7A96', '#353B49' ] ]
let s:p.inactive.middle = [ [ '#6C7A96', '#353B49' ] ]
let s:p.inactive.right = [ [ '#6C7A96', '#3B4252' ], [ '#6C7A96', '#3B4252' ], [ '#6C7A96', '#353B49' ] ]

let s:p.insert.left = [ [ '#2E3440', '#A3BE8C' ], [ '#A3BE8C', '#3F4758' ] ]
let s:p.insert.middle = [ [ '#6C7A96', '#353B49' ] ]
let s:p.insert.right = [ [ '#2E3440', '#A3BE8C' ], [ '#A3BE8C', '#3F4758' ] ]

let s:p.normal.left = [ [ '#2E3440', '#88C0D0' ], [ '#88C0D0', '#3F4758' ], [ '#C8D0E0', '#353B49' ] ]
let s:p.normal.middle = [ [ '#6C7A96', '#353B49' ] ]
let s:p.normal.right = [ [ '#2E3440', '#88C0D0' ], [ '#88C0D0', '#3F4758' ], [ '#C8D0E0', '#353B49' ] ]

let s:p.tabline.left = [ [ '#E5E9F0', '#4C566A' ] ]
let s:p.tabline.right = [ [ '#2E3440', '#88C0D0' ], [ '#88C0D0', '#3F4758' ], [ '#C8D0E0', '#353B49' ] ]
let s:p.tabline.tabsel = [ [ '#2E3440', '#88C0D0' ], [ '#88C0D0', '#3F4758' ], [ '#C8D0E0', '#353B49' ] ]

let s:p.replace.left = [ [ '#2E3440', '#D57780' ], [ '#D57780', '#3F4758' ] ]
let s:p.replace.middle = [ [ '#6C7A96', '#353B49' ] ]
let s:p.replace.right = [ [ '#2E3440', '#D57780' ], [ '#D57780', '#3F4758' ] ]

let s:p.visual.left = [ [ '#2E3440', '#B988B0' ], [ '#B988B0', '#3F4758' ] ]
let s:p.visual.middle = [ [ '#6C7A96', '#353B49' ] ]
let s:p.visual.right = [ [ '#2E3440', '#B988B0' ], [ '#B988B0', '#3F4758' ] ]

let g:lightline#colorscheme#onenord#palette = lightline#colorscheme#fill(s:p)
