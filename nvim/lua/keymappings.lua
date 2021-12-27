local utils = require('utils')
local augroup, map = utils.augroup, utils.map

-- Window Management
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

-- Navigate Quickfix
map('n', '[q', '<cmd>cprevious<CR>')
map('n', ']q', '<cmd>cnext<CR>')
map('n', '[Q', '<cmd>cfirst<CR>')
map('n', ']Q', '<cmd>clast<CR>')
map('n', '[<C-q>', '<cmd>cpfile<CR>')
map('n', ']<C-q>', '<cmd>cnfile<CR>')

-- Navigate Location List
map('n', '[l', '<cmd>lprevious<CR>')
map('n', ']l', '<cmd>lnext<CR>')
map('n', '[L', '<cmd>lfirst<CR>')
map('n', ']L', '<cmd>llast<CR>')
map('n', '[<C-l>', '<cmd>lpfile<CR>')
map('n', ']<C-l>', '<cmd>lnfile<CR>')

map('n', '<leader>so', '<cmd>luafile %<CR>')
map('n', '<leader>rp', '<cmd>lua require("reload").reload_plugins()<CR>')

map('n', '<leader>rn', '<cmd>lua require("rename").smart_rename()<CR>')

-- Plugins
-- Comment Frame
map('n', '<leader>cf', '<cmd>lua require("nvim-comment-frame").add_multiline_comment()<CR>')

-- Formatter
function _G.GetFormatters()
  return table.concat(vim.tbl_keys(require('plugins.formatter').formatters), '\n')
end

vim.api.nvim_exec(
  [[
  command! FormatterUpdateAll lua require('plugins.formatter').update_all_formatters()
  command! -nargs=? -complete=custom,v:lua.GetFormatters FormatterUpdate lua require('plugins.formatter').update_formatters(<f-args>)
]],
  true
)
augroup('auto_format', {
  { 'BufWritePost', '*', 'lua require("plugins.formatter").format_on_save()' },
})

-- Maximizer
map('n', '<leader>mt', '<cmd>MaximizerToggle<CR>')

-- Packer
map('n', '<leader>ps', '<cmd>PackerSync<CR>')
map('n', '<leader>pu', '<cmd>PackerUpdate<CR>')
map('n', '<leader>pp', '<cmd>PackerProfile<CR>')
map('n', '<leader>pl', ':PackerLoad ')

-- Startup Time
map('n', '<leader>su', '<cmd>StartupTime --tries 20<CR>')

-- Telescope
map('n', '<leader>ht', '<cmd>Telescope help_tags<CR>')
map('n', '<leader>hi', '<cmd>Telescope highlights<CR>')

map('n', '<C-p>', '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>')
map('n', '<leader>ff', '<cmd>Telescope find_files find_command=rg,--no-ignore,--hidden,--files<CR>')
map('n', '<leader>rg', ':Telescope grep_string search=')
map('n', '<leader>/', '<cmd>Telescope live_grep only_sort_text=true<CR>')
map('n', '<leader>fw', '<cmd>Telescope grep_string<CR>')
map('n', '<leader>gs', '<cmd>Telescope git_status<CR>')
map('n', '<leader>bu', '<cmd>Telescope buffers sort_mru=true<CR>')
map('n', '<leader>of', '<cmd>Telescope oldfiles cwd_only=true sort_lastused=true include_current_session=true<CR>')

map('n', 'gi', '<cmd>Telescope lsp_implementations<CR>')
map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
map('n', 'gr', '<cmd>Telescope lsp_references<CR>')

map('n', '<leader>ca', '<cmd>Telescope lsp_code_actions<CR>')
map('x', '<leader>ca', '<cmd>Telescope lsp_range_code_actions theme=cursor<CR>')

map('n', '<leader>sw', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')
map('n', '<leader>sd', '<cmd>Telescope lsp_document_symbols<CR>')

-- Test
map('n', '<leader>tn', '<cmd>TestNearest<CR>')
map('n', '<leader>tf', '<cmd>TestFile<CR>')
map('n', '<leader>ts', '<cmd>TestSuite<CR>')
map('n', '<leader>tl', '<cmd>TestLast<CR>')
map('n', '<leader>tv', '<cmd>TestVisit<CR>')

-- Tree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>n', '<cmd>NvimTreeFindFileToggle<CR>')
