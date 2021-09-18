local cmd, g = vim.cmd, vim.g
local colors = require('colors')
local utils = require('utils')
local get_highlight_string, augroup = utils.get_highlight_string, utils.augroup

local function highlight_autocmd(name, highlight)
  return { 'ColorScheme', '*', get_highlight_string(name, highlight) }
end

local function highlight_link(name, to)
  return { 'ColorScheme', '*', 'highlight link ' .. name .. ' ' .. to }
end

local lsp_types = {
  Error = colors.red,
  Hint = colors.cyan,
  Information = colors.blue,
  Warning = colors.yellow,
}
local lsp_highlights = {}
for type, color in pairs(lsp_types) do
  table.insert(lsp_highlights, highlight_autocmd('Diagnostic' .. type, { guifg = color }))
  table.insert(lsp_highlights, highlight_autocmd('DiagnosticFloating' .. type, { guifg = color, guibg = colors.bg2 }))
  table.insert(lsp_highlights, highlight_autocmd('DiagnosticSign' .. type, { guifg = color }))
  table.insert(
    lsp_highlights,
    highlight_autocmd('DiagnosticUnderline' .. type, { guifg = color, gui = 'bold,underline' })
  )
  table.insert(lsp_highlights, highlight_autocmd('DiagnoticVirtualText' .. type, { guifg = color }))
end
augroup('lsp_highlights', lsp_highlights)

augroup('custom_highlights', {
  highlight_autocmd('CursorLineNr', { guifg = colors.blue }),
  highlight_autocmd('NormalFloat', { guifg = colors.fg, guibg = colors.bg0 }),

  -- Current definition conflicts with quick-scope
  highlight_autocmd('TSDefinition', { gui = 'reverse' }),

  -- Telescope
  highlight_link('TelescopeSelection', 'CursorLine'),
  highlight_autocmd('TelescopeResultsDiffAdd', { guifg = colors.green }),
  highlight_autocmd('TelescopeResultsDiffChange', { guifg = colors.yellow }),
  highlight_autocmd('TelescopeResultsDiffDelete', { guifg = colors.red }),
  highlight_autocmd('TelescopeResultsDiffUntracked', { guifg = colors.blue }),

  -- Used for preview window cursor highlight
  { 'ColorScheme', '*', 'let g:terminal_color_8 = "' .. colors.bg1 .. '"' },
})

g.edge_style = 'neon'
g.edge_diagnostic_virtual_text = 'colored'
g.edge_better_performance = 1

cmd('silent! colorscheme edge')
