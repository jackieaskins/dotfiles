vim.o.completeopt = 'menu,menuone,noselect'

require'compe'.setup {
  enabled = true;
  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  }
}

local compe_opts = { silent = true, expr = true, noremap = true }
vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', compe_opts)
vim.api.nvim_set_keymap('i', '<C-e>', 'compe#close("<C-e>")', compe_opts)
vim.api.nvim_set_keymap('i', '<C-f>', 'compe#scroll({ "delta": +4 })', compe_opts)
vim.api.nvim_set_keymap('i', '<C-b>', 'compe#scroll({ "delta": -4 })', compe_opts)

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#confirm']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

local vsnip_opts = { expr = true, silent = true }
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", vsnip_opts)
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", vsnip_opts)
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", vsnip_opts)
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", vsnip_opts)

vim.g['vsnip_snippet_dir'] = vim.fn.expand("$HOME/dotfiles/vim-common/snippets/")
