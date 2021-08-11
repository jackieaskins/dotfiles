if exists("b:current_syntax")
  finish
endif

syntax sync fromstart

syntax region MyDashboardHeader start=/█\|╚/ end=/╗\|║\|╝/
syntax match MyDashboardVersion /Version:.*/

syntax region MyDashboardBrackets start=/\[/ end=/\]/ contained
syntax match MyDashboardDirectory /[^\]]*\// contained
syntax match MyDashboardFile /\[.\][^<quit>].*/ contains=MyDashboardBrackets,MyDashboardDirectory
syntax match MyDashboardMRU /MRU.*/

highlight default link MyDashboardHeader Directory
highlight default link MyDashboardMRU Constant
highlight default link MyDashboardBrackets Statement
highlight default link MyDashboardFile Function

let b:current_syntax = 'my_dashboard'
