
"--------------------------------------------------------------------"
"                        onenord colorscheme                         "
"              Extracted from onenord.nvim by rmehri01               "
"              https://github.com/rmehri01/onenord.nvim              "
"--------------------------------------------------------------------"

highlight clear

if exists('syntax_on')
  syntax reset
endif

set background=dark
let g:colors_name = 'onenord'

let g:terminal_ansi_colors = [
      \ '#3B4252',
      \ '#D57780',
      \ '#A3BE8C',
      \ '#EBCB8B',
      \ '#81A1C1',
      \ '#B988B0',
      \ '#88C0D0',
      \ '#C8D0E0',
      \ '#4C566A',
      \ '#D57780',
      \ '#A3BE8C',
      \ '#EBCB8B',
      \ '#81A1C1',
      \ '#B48EAD',
      \ '#8FBCBB',
      \ '#E5E9F0',
      \ ]

highlight Keyword guifg=#B988B0 guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight markdownCodeDelimiter guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownCodeBlock guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownCode guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownBold guifg=#B988B0 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight markdownBlockquote guifg=#6C7A96 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight htmlH5 guifg=#B988B0 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight htmlH4 guifg=#EBCB8B guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight htmlH3 guifg=#A3BE8C guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight htmlH2 guifg=#D57780 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight LspSagaAutoPreview guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspSagaFinderSelection guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspSagaSignatureHelpBorder guifg=#DE878F guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspSagaCodeActionTruncateLine guifg=#3F4758 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspSagaCodeActionBorder guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspSagaCodeActionContent guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspSagaCodeActionTitle guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspSagaDefPreviewBorder guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspSagaRenameBorder guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspSagaHoverBorder guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspSagaBorderTitle guifg=#88C0D0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LineDiagTruncateLine guifg=#3F4758 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Tag guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight SpecialChar guifg=#DE878F guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Special guifg=#DE878F guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight PreCondit guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Typedef guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Macro guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Define guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Include guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight PreProc guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Exception guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Label guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Statement guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Float guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Character guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Structure guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight StorageClass guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight EndOfBuffer guifg=#2E3440 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight VertSplit guifg=#4C566A guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight SignColumn guifg=#C8D0E0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NormalNC guifg=NONE guibg=#2E3440 guisp= gui=NONE cterm=NONE term=NONE
highlight Normal guifg=#C8D0E0 guibg=#2E3440 guisp= gui=NONE cterm=NONE term=NONE
highlight DashboardFooter guifg=#A3BE8C guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight DashboardCenter guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight DashboardHeader guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight DashboardShortCut guifg=#88C0D0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight healthWarning guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight healthSuccess guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight healthError guifg=#BF616A guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Warnings guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CommandMode guifg=#EBCB8B guibg=NONE guisp= gui=reverse cterm=reverse term=reverse
highlight VisualMode guifg=#B988B0 guibg=NONE guisp= gui=reverse cterm=reverse term=reverse
highlight ReplacelMode guifg=#D57780 guibg=NONE guisp= gui=reverse cterm=reverse term=reverse
highlight InsertMode guifg=#A3BE8C guibg=NONE guisp= gui=reverse cterm=reverse term=reverse
highlight NormalMode guifg=#88C0D0 guibg=NONE guisp= gui=reverse cterm=reverse term=reverse
highlight CursorLine guifg=NONE guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight CursorColumn guifg=NONE guibg=#3B4252 guisp= gui=NONE cterm=NONE term=NONE
highlight WildMenu guifg=#EBCB8B guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight Whitespace guifg=#646A76 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight VisualNOS guifg=NONE guibg=#3F4758 guisp= gui=NONE cterm=NONE term=NONE
highlight Visual guifg=NONE guibg=#3F4758 guisp= gui=NONE cterm=NONE term=NONE
highlight Title guifg=#A3BE8C guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight Tabline guifg=#6C7A96 guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight TablineSel guifg=#88C0D0 guibg=#2E3440 guisp= gui=NONE cterm=NONE term=NONE
highlight TabLineFill guifg=#6C7A96 guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight StatusLineTermNC guifg=#6C7A96 guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight StatusLineTerm guifg=#C8D0E0 guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight StatusLineNC guifg=#6C7A96 guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight StatusLine guifg=#C8D0E0 guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight GitSignsChangeLn guifg=#5E81AC guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight SpecialKey guifg=#5E81AC guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Search guifg=#81A1C1 guibg=#4C566A guisp= gui=bold cterm=bold term=bold
highlight qfLineNr guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight QuickFixLine guifg=NONE guibg=#3B4252 guisp= gui=bold,italic cterm=bold,italic term=bold,italic
highlight Question guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight PmenuThumb guifg=NONE guibg=#C8D0E0 guisp= gui=NONE cterm=NONE term=NONE
highlight PmenuSbar guifg=NONE guibg=#3B4252 guisp= gui=NONE cterm=NONE term=NONE
highlight PmenuSel guifg=NONE guibg=#4C566A guisp= gui=NONE cterm=NONE term=NONE
highlight Pmenu guifg=#C8D0E0 guibg=#3B4252 guisp= gui=NONE cterm=NONE term=NONE
highlight NonText guifg=#646A76 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight MoreMsg guifg=#81A1C1 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight ModeMsg guifg=#81A1C1 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight MatchParen guifg=#EBCB8B guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight LineNr guifg=#6C7A96 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight FoldColumn guifg=#6C7A96 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Folded guifg=#5E81AC guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight DiffText guifg=NONE guibg=#405D7E guisp= gui=NONE cterm=NONE term=NONE
highlight DiffDelete guifg=NONE guibg=#4D2B2E guisp= gui=NONE cterm=NONE term=NONE
highlight DiffChange guifg=NONE guibg=#39495D guisp= gui=NONE cterm=NONE term=NONE
highlight DiffAdd guifg=NONE guibg=#394E3D guisp= gui=NONE cterm=NONE term=NONE
highlight Directory guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CursorIM guifg=#C8D0E0 guibg=NONE guisp= gui=reverse cterm=reverse term=reverse
highlight Cursor guifg=#C8D0E0 guibg=NONE guisp= gui=reverse cterm=reverse term=reverse
highlight Conceal guifg=NONE guibg=#2E3440 guisp= gui=NONE cterm=NONE term=NONE
highlight ColorColumn guifg=NONE guibg=#3B4252 guisp= gui=NONE cterm=NONE term=NONE
highlight FloatBorder guifg=#81A1C1 guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight TSVariableBuiltin guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSVariable guifg=#C8D0E0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSTypeBuiltin guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSType guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSDanger guifg=#BF616A guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight TSWarning guifg=#D08F70 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight TSNote guifg=#A3BE8C guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight TSEnvironmentName guifg=#C8D0E0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSEnvironment guifg=#C8D0E0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSTextReference guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSMath guifg=#C8D0E0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight ErrorMsg guifg=#BF616A guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSLiteral guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSTitle guifg=#81A1C1 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight TSUnderline guifg=NONE guibg=NONE guisp= gui=underline cterm=underline term=underline
highlight TSEmphasis guifg=#EBCB8B guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight TSStrong guifg=#B988B0 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight TSText guifg=#C8D0E0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSTagDelimiter guifg=#5E81AC guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSTagAttribute guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSTag guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSSymbol guifg=#88C0D0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSStringEscape guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSStringRegex guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSString guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSRepeat guifg=#B988B0 guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight TSPunctSpecial guifg=#5E81AC guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSPunctBracket guifg=#5E81AC guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSPunctDelimiter guifg=#5E81AC guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindInterface guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindClass guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindField guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindConstructor guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindFunction guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindMethod guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindText guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemMenu guifg=#6C7A96 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemAbbrMatchFuzzy guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemAbbrMatch guifg=#81A1C1 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight TSKeywordFunction guifg=#B988B0 guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight TSKeyword guifg=#B988B0 guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight TSInclude guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSFuncMacro guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSFuncBuiltin guifg=#88C0D0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSFunction guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSFloat guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSField guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSException guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSError guifg=#BF616A guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSConstructor guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSConstMacro guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSConstBuiltin guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSConstant guifg=#88C0D0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSConditional guifg=#B988B0 guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight TSComment guifg=#6C7A96 guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight TSCharacter guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSBoolean guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSAttribute guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsSignHint guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsFloatingHint guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsUnderlineHint guifg=NONE guibg=NONE guisp=#B988B0 gui=undercurl cterm=undercurl term=undercurl
highlight LspDiagnosticsVirtualTextHint guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsSignInformation guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsFloatingInformation guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsUnderlineInformation guifg=NONE guibg=NONE guisp=#A3BE8C gui=undercurl cterm=undercurl term=undercurl
highlight LspDiagnosticsVirtualTextInformation guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsSignError guifg=#BF616A guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsFloatingError guifg=#BF616A guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsUnderlineError guifg=NONE guibg=NONE guisp=#BF616A gui=undercurl cterm=undercurl term=undercurl
highlight LspDiagnosticsVirtualTextError guifg=#BF616A guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsSignWarning guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsFloatingWarning guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsUnderlineWarning guifg=NONE guibg=NONE guisp=#D08F70 gui=undercurl cterm=undercurl term=undercurl
highlight LspDiagnosticsVirtualTextWarning guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight DiagnosticHint guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticHint LspDiagnosticsDefaultHint
highlight LspDiagnosticsDefaultHint guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight DiagnosticInfo guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticInfo LspDiagnosticsDefaultInformation
highlight LspDiagnosticsDefaultInformation guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight DiagnosticWarn guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticWarn LspDiagnosticsDefaultWarning
highlight LspDiagnosticsDefaultWarning guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight DiagnosticError guifg=#BF616A guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticError LspDiagnosticsDefaultError
highlight LspDiagnosticsDefaultError guifg=#BF616A guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LightspeedOneCharMatch guifg=#EBCB8B guibg=NONE guisp= gui=bold,reverse cterm=bold,reverse term=bold,reverse
highlight LightspeedUnlabeledMatch guifg=#E5E9F0 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight LightspeedGreyWash guifg=#646A76 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LightspeedMaskedChar guifg=#B48EAD guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LightspeedShortcut guifg=#E5E9F0 guibg=#E85B7A guisp= gui=bold,underline cterm=bold,underline term=bold,underline
highlight LightspeedLabelDistantOverlapped guifg=#81A1C1 guibg=NONE guisp= gui=underline cterm=underline term=underline
highlight LightspeedLabelDistant guifg=#88C0D0 guibg=NONE guisp= gui=bold,underline cterm=bold,underline term=bold,underline
highlight LightspeedLabelOverlapped guifg=#E44675 guibg=NONE guisp= gui=underline cterm=underline term=underline
highlight LightspeedLabel guifg=#E85B7A guibg=NONE guisp= gui=bold,underline cterm=bold,underline term=bold,underline
highlight FernBranchText guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight HopUnmatched guifg=#6C7A96 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight HopNextKey2 guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight HopNextKey1 guifg=#88C0D0 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight HopNextKey guifg=#E5E9F0 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight illuminatedCurWord guifg=NONE guibg=#3F4758 guisp= gui=NONE cterm=NONE term=NONE
highlight illuminatedWord guifg=NONE guibg=#3F4758 guisp= gui=NONE cterm=NONE term=NONE
highlight DapStopped guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight DapBreakpoint guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight IndentBlanklineContextChar guifg=#B988B0 guibg=NONE guisp= gui=nocombine cterm=nocombine term=nocombine
highlight IndentBlanklineChar guifg=#4C566A guibg=NONE guisp= gui=nocombine cterm=nocombine term=nocombine
highlight SneakScope guifg=NONE guibg=#4C566A guisp= gui=NONE cterm=NONE term=NONE
highlight Sneak guifg=#2E3440 guibg=#C8D0E0 guisp= gui=NONE cterm=NONE term=NONE
highlight BufferInactiveTarget guifg=#D57780 guibg=#353B49 guisp= gui=bold cterm=bold term=bold
highlight BufferInactiveSign guifg=#6C7A96 guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight BufferInactiveMod guifg=#EBCB8B guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight BufferInactiveIndex guifg=#6C7A96 guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight BufferInactive guifg=#6C7A96 guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight BufferVisibleTarget guifg=#D57780 guibg=#2E3440 guisp= gui=bold cterm=bold term=bold
highlight BufferVisibleSign guifg=#6C7A96 guibg=#2E3440 guisp= gui=NONE cterm=NONE term=NONE
highlight BufferVisibleMod guifg=#EBCB8B guibg=#2E3440 guisp= gui=bold cterm=bold term=bold
highlight BufferVisibleIndex guifg=#C8D0E0 guibg=#2E3440 guisp= gui=NONE cterm=NONE term=NONE
highlight BufferVisible guifg=#C8D0E0 guibg=#2E3440 guisp= gui=NONE cterm=NONE term=NONE
highlight BufferCurrentTarget guifg=#D57780 guibg=#2E3440 guisp= gui=bold cterm=bold term=bold
highlight LspCodeLens guifg=#6C7A96 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight BufferCurrentMod guifg=#EBCB8B guibg=#2E3440 guisp= gui=bold cterm=bold term=bold
highlight BufferCurrentIndex guifg=#C8D0E0 guibg=#2E3440 guisp= gui=NONE cterm=NONE term=NONE
highlight BufferCurrent guifg=#C8D0E0 guibg=#2E3440 guisp= gui=NONE cterm=NONE term=NONE
highlight BufferLineFill guifg=NONE guibg=#2E3440 guisp= gui=NONE cterm=NONE term=NONE
highlight BufferLineIndicatorSelected guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Error guifg=#BF616A guibg=NONE guisp= gui=bold,underline cterm=bold,underline term=bold,underline
highlight LspSignatureActiveParameter guifg=NONE guibg=#434C5E guisp= gui=bold cterm=bold term=bold
highlight DiagnosticVirtualTextHint guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticVirtualTextHint LspDiagnosticsVirtualTextHint
highlight DiagnosticVirtualTextError guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticVirtualTextError LspDiagnosticsVirtualTextError
highlight DiagnosticVirtualTextWarn guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticVirtualTextWarn LspDiagnosticsVirtualTextWarning
highlight DiagnosticVirtualTextInfo guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticVirtualTextInfo LspDiagnosticsVirtualTextInformation
highlight DiagnosticUnderlineHint guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticUnderlineHint LspDiagnosticsUnderlineHint
highlight DiagnosticUnderlineError guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticUnderlineError LspDiagnosticsUnderlineError
highlight DiagnosticUnderlineWarn guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticUnderlineWarn LspDiagnosticsUnderlineWarning
highlight DiagnosticUnderlineInfo guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticUnderlineInfo LspDiagnosticsUnderlineInformation
highlight DiagnosticFloatingHint guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticFloatingHint LspDiagnosticsFloatingHint
highlight DiagnosticFloatingError guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticFloatingError LspDiagnosticsFloatingError
highlight DiagnosticFloatingWarn guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticFloatingWarn LspDiagnosticsFloatingWarning
highlight DiagnosticFloatingInfo guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticFloatingInfo LspDiagnosticsFloatingInformation
highlight DiagnosticSignHint guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticSignHint LspDiagnosticsSignHint
highlight DiagnosticSignError guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticSignError LspDiagnosticsSignError
highlight DiagnosticSignWarn guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticSignWarn LspDiagnosticsSignWarning
highlight DiagnosticSignInfo guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight! link DiagnosticSignInfo LspDiagnosticsSignInformation
highlight WarningMsg guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TelescopeResultsDiffDelete guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TelescopeResultsDiffChange guifg=#5E81AC guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TelescopeResultsDiffAdd guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TelescopeTitle guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight SpellLocal guifg=NONE guibg=NONE guisp=#88C0D0 gui=italic,undercurl cterm=italic,undercurl term=italic,undercurl
highlight SpellRare guifg=NONE guibg=NONE guisp=#B988B0 gui=italic,undercurl cterm=italic,undercurl term=italic,undercurl
highlight SpellCap guifg=NONE guibg=NONE guisp=#EBCB8B gui=italic,undercurl cterm=italic,undercurl term=italic,undercurl
highlight SpellBad guifg=NONE guibg=NONE guisp=#D57780 gui=italic,undercurl cterm=italic,undercurl term=italic,undercurl
highlight QuickScopeSecondary guifg=#B988B0 guibg=NONE guisp= gui=underline cterm=underline term=underline
highlight QuickScopePrimary guifg=#5E81AC guibg=NONE guisp= gui=underline cterm=underline term=underline
highlight Identifier guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CursorLineNr guifg=#81A1C1 guibg=#353B49 guisp= gui=bold cterm=bold term=bold
highlight TelescopeResultsDiffUntracked guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight htmlH1 guifg=#88C0D0 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight htmlLink guifg=#A3BE8C guibg=NONE guisp= gui=underline cterm=underline term=underline
highlight Repeat guifg=#B988B0 guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight Conditional guifg=#B988B0 guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight Todo guifg=#EBCB8B guibg=NONE guisp= gui=bold,italic cterm=bold,italic term=bold,italic
highlight TSNamespace guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSMethod guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSLabel guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight SpecialComment guifg=#6C7A96 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Delimiter guifg=#5E81AC guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight ReferencesCount guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight DefinitionCount guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight DefinitionPreviewTitle guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight DefinitionIcon guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindProperty guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TargetWord guifg=#88C0D0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSURI guifg=#88C0D0 guibg=NONE guisp= gui=underline cterm=underline term=underline
highlight ReferencesIcon guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Debug guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Underlined guifg=#A3BE8C guibg=NONE guisp= gui=underline cterm=underline term=underline
highlight Ignore guifg=#88C0D0 guibg=#2E3440 guisp= gui=bold cterm=bold term=bold
highlight IncSearch guifg=#EBCB8B guibg=#4C566A guisp= gui=bold,underline cterm=bold,underline term=bold,underline
highlight LspSagaDocTruncateLine guifg=#3F4758 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindTypeParameter guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspSagaShTruncateLine guifg=#3F4758 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight ProviderTruncateLine guifg=#3F4758 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspSagaDiagnosticTruncateLine guifg=#3F4758 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspSagaDiagnosticHeader guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownUrl guifg=#88C0D0 guibg=NONE guisp= gui=underline cterm=underline term=underline
highlight markdownRule guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownOrderedListMarker guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownListMarker guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownLinkText guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownItalic guifg=#EBCB8B guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight markdownLinkDelimiter guifg=#6C7A96 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownIdDelimiter guifg=#6C7A96 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownIdDeclaration guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownId guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownH6Delimiter guifg=#8FBCBB guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownH5Delimiter guifg=#8FBCBB guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownH4Delimiter guifg=#8FBCBB guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownH3Delimiter guifg=#88C0D0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownH2Delimiter guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownH1Delimiter guifg=#5E81AC guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownH6 guifg=#8FBCBB guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownH5 guifg=#8FBCBB guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownH4 guifg=#8FBCBB guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight markdownH3 guifg=#88C0D0 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight markdownH2 guifg=#81A1C1 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight markdownH1 guifg=#5E81AC guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight NotifyTRACEBorder guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspSagaDiagnosticBorder guifg=#646A76 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight DiagnosticInformation guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight DiagnosticWarning guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspFloatWinBorder guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NotifyTRACEIcon guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NotifyERRORTitle guifg=#BF616A guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspFloatWinNormal guifg=#C8D0E0 guibg=#2E3440 guisp= gui=NONE cterm=NONE term=NONE
highlight WhichKeyFloat guifg=NONE guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight WhichKeySeperator guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight WhichKeyDesc guifg=#81A1C1 guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight WhichKeyGroup guifg=#88C0D0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight WhichKey guifg=#B988B0 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight LspDiagnosticsHint guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsInformation guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsWarning guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspDiagnosticsError guifg=#BF616A guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NvimTreeVertSplit guifg=#353B49 guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight NvimTreeCursorLine guifg=NONE guibg=#3B4252 guisp= gui=NONE cterm=NONE term=NONE
highlight NvimTreeNormal guifg=#C8D0E0 guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight diffLine guifg=#6C7A96 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NvimTreeImageFile guifg=#B988B0 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight NvimTreeSpecialFile guifg=#D08F70 guibg=NONE guisp= gui=underline cterm=underline term=underline
highlight NvimTreeOpenedFile guifg=NONE guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NvimTreeExecFile guifg=#A3BE8C guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight NvimTreeGitDeleted guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NvimTreeGitStaged guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NvimTreeGitNew guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NvimTreeGitDirty guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NvimTreeIndentMarker guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NvimTreeOpenedFolderName guifg=#EBCB8B guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight NvimTreeEmptyFolderName guifg=#6C7A96 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight LspReferenceWrite guifg=NONE guibg=NONE guisp=#EBCB8B gui=underline cterm=underline term=underline
highlight LspReferenceRead guifg=NONE guibg=NONE guisp=#EBCB8B gui=underline cterm=underline term=underline
highlight LspReferenceText guifg=NONE guibg=NONE guisp=#EBCB8B gui=underline cterm=underline term=underline
highlight NvimTreeFolderIcon guifg=#5E81AC guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NvimTreeFolderName guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NvimTreeRootFolder guifg=#A3BE8C guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight NvimTreeSymlink guifg=#88C0D0 guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight TelescopeMatching guifg=#EBCB8B guibg=NONE guisp= gui=bold cterm=bold term=bold
highlight TelescopeSelection guifg=#88C0D0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TelescopeSelectionCaret guifg=#88C0D0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TelescopePreviewBorder guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TelescopeResultsBorder guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TelescopePromptBorder guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TelescopePromptPrefix guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TelescopeNormal guifg=#C8D0E0 guibg=#2E3440 guisp= gui=NONE cterm=NONE term=NONE
highlight GitSignsDeleteLn guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight GitSignsDeleteNr guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight GitSignsDelete guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight GitSignsChangeNr guifg=#5E81AC guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight GitSignsChange guifg=#5E81AC guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight GitSignsAddLn guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight GitSignsAddNr guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight GitSignsAdd guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight GitGutterDelete guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight GitGutterChange guifg=#5E81AC guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight GitGutterAdd guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NeogitNotificationError guifg=#BF616A guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NeogitNotificationWarning guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NeogitNotificationInfo guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NeogitDiffAddHighlight guifg=#A3BE8C guibg=#394E3D guisp= gui=NONE cterm=NONE term=NONE
highlight NeogitDiffDeleteHighlight guifg=#D57780 guibg=#4D2B2E guisp= gui=NONE cterm=NONE term=NONE
highlight NeogitDiffContextHighlight guifg=NONE guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight NeogitHunkHeaderHighlight guifg=#EBCB8B guibg=#3F4758 guisp= gui=NONE cterm=NONE term=NONE
highlight NeogitHunkHeader guifg=#C8D0E0 guibg=#3F4758 guisp= gui=NONE cterm=NONE term=NONE
highlight NeogitRemote guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NeogitBranch guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight diffIndexLine guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NormalFloat guifg=#C8D0E0 guibg=#353B49 guisp= gui=NONE cterm=NONE term=NONE
highlight diffFile guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight diffNewFile guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight diffOldFile guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight diffChanged guifg=#5E81AC guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight diffRemoved guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight diffAdded guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TroubleText guifg=#C8D0E0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TroubleNormal guifg=#C8D0E0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TroubleCount guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NotifyTRACETitle guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NotifyDEBUGTitle guifg=#6C7A96 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NotifyINFOTitle guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NotifyWARNTitle guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Comment guifg=#6C7A96 guibg=NONE guisp= gui=italic cterm=italic term=italic
highlight Type guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NotifyDEBUGIcon guifg=#6C7A96 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NotifyINFOIcon guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NotifyWARNIcon guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NotifyERRORIcon guifg=#BF616A guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Constant guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NotifyDEBUGBorder guifg=#6C7A96 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NotifyINFOBorder guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NotifyWARNBorder guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight NotifyERRORBorder guifg=#BF616A guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Operator guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindStruct guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindConstant guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindEnumMember guifg=#88C0D0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindFile guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindSnippet guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindKeyword guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindEnum guifg=#EBCB8B guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindValue guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Function guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemKindModule guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight BufferCurrentSign guifg=#88C0D0 guibg=#2E3440 guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemAbbr guifg=#C8D0E0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight CmpItemAbbrDeprecated guifg=#C8D0E0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSKeywordOperator guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSKeywordReturn guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Boolean guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight Number guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight String guifg=#A3BE8C guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSNumber guifg=#D08F70 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSOperator guifg=#B988B0 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSParameter guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSParameterReference guifg=#D57780 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
highlight TSProperty guifg=#81A1C1 guibg=NONE guisp= gui=NONE cterm=NONE term=NONE
