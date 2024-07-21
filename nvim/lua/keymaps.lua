local utils = require('utils')
local augroup, map = utils.augroup, utils.map

-- Append semicolons and commas {{{
map('n', '<leader>;', 'A;<Esc>')
map('n', '<leader>,', 'A,<Esc>')
-- }}}

-- Clipboard and visual select {{{
-- Yank to/from System Clipboard
local yank_keys = { 'c', 'C', 'd', 'D', 'p', 'P', 'y', 'Y' }
for _, key in ipairs(yank_keys) do
  map({ 'n', 'v' }, '<leader>' .. key, '"+' .. key)
end

-- Borrowed from https://github.com/Abstract-IDE/abstract-autocmds
-- Keep selection after indenting
map('x', '<', '<gv')
map('x', '>', '>gv')

-- Below mappings from https://www.reddit.com/r/neovim/comments/1e1dmpw/what_are_the_keymaps_that_you_replaced_default/
-- Don't overwrite clipboard on `x`
map('n', 'x', '"_x"')

-- Swap blockwise selection
map('n', 'v', '<C-v>')
map('n', '<C-v>', 'v')
-- }}}

-- Auto-indent {{{
-- https://www.reddit.com/r/neovim/comments/17mrka2/comment/k7n3d9b
map('n', 'i', function()
  if #vim.fn.getline('.') == 0 then
    return [["_cc]]
  else
    return 'i'
  end
end, { expr = true, desc = 'Properly indent empty line on insert' })
-- }}}

-- Diagnostics {{{
map('n', '[e', '<cmd>lua vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })<CR>')
map('n', ']e', '<cmd>lua vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })<CR>')
-- }}}

-- LSP {{{
-- Unmap some of the default LSP mappings
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'grr')
vim.keymap.del({ 'n', 'x' }, 'gra')

augroup('lsp_keymaps', {
  {
    'LspAttach',
    callback = function(args)
      local bsk = utils.buffer_map(args.buf)
      bsk({ 'i', 'n' }, '<C-S>', vim.lsp.buf.signature_help, { desc = 'vim.lsp.buf.signature_help' })

      bsk('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'vim.lsp.buf.rename' })
      bsk('n', '<leader>bf', function()
        vim.lsp.buf.format({ async = true })
      end, { desc = 'vim.lsp.buf.format' })

      bsk('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'vim.lsp.buf.code_action' })
      bsk('x', '<leader>ca', vim.lsp.buf.code_action, { desc = 'vim.lsp.buf.range_code_action' })

      bsk('n', '<leader>ih', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
      end, { desc = 'vim.lsp.inlay_hint toggle' })

      bsk('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'vim.lsp.buf.add_workspace_folder' })
      bsk('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'vim.lsp.buf.remove_workspace_folder' })
      bsk('n', '<leader>wl', '<cmd>lua =vim.lsp.buf.list_workspace_folders()<CR>')

      bsk({ 'n', 'v' }, 'K', function()
        local curr_word = vim.fn.expand('<cWORD>')

        if curr_word:match('vim%.opt%.%S+') then
          local parts = vim.split(curr_word, '.', { plain = true })
          vim.cmd.help("'" .. parts[#parts] .. "'")
        else
          vim.lsp.buf.hover()
        end
      end, { desc = 'Hover' })
    end,
  },
})
-- }}}

-- Extended gx {{{
map('n', 'gx', function()
  require('gx').handle_url_under_cursor()
end, { desc = 'Open url under cursor' })
-- }}}

-- Jumplist {{{
local function jump(key)
  return function()
    return vim.v.count > 1 and "m'" .. vim.v.count .. key or key
  end
end
map('n', 'k', jump('k'), { desc = 'Jump [count] lines up', expr = true })
map('n', 'j', jump('j'), { desc = 'Jump [count] lines down', expr = true })
-- }}}

-- Unimpaired {{{
-- Navigate Quickfix
map('n', '[q', vim.cmd.cprevious)
map('n', ']q', vim.cmd.cnext)
map('n', '[Q', vim.cmd.cfirst)
map('n', ']Q', vim.cmd.clast)
map('n', '[<C-q>', vim.cmd.cpfile)
map('n', ']<C-q>', vim.cmd.cnfile)

-- Navigate Location List
map('n', '[l', vim.cmd.lprevious)
map('n', ']l', vim.cmd.lnext)
map('n', '[L', vim.cmd.lfirst)
map('n', ']L', vim.cmd.llast)
map('n', '[<C-l>', vim.cmd.lpfile)
map('n', ']<C-l>', vim.cmd.lnfile)

-- Navigate Files
map('n', '[n', vim.cmd.previous)
map('n', ']n', vim.cmd.next)
map('n', '[N', vim.cmd.first)
map('n', ']N', vim.cmd.last)
-- }}}

-- Runner {{{
vim.tbl_map(function(value)
  local key, fn = value[1], value[2]

  map('n', key, function()
    require('runner')[fn]()
  end, { desc = 'runner - ' .. fn })
end, {
  { '<leader>vo', 'open_runner' },
  { '<leader>vt', 'toggle_pane' },
  { '<leader>vq', 'close_runner' },
  { '<leader>vi', 'interrupt_runner' },
  { '<leader>vl', 'run_last_command' },
  { '<leader>vc', 'clear_terminal_screen' },
})

map('n', '<leader>vr', function()
  vim.ui.input({
    prompt = 'Enter command: ',
    completion = 'shellcmd',
  }, function(input)
    if input then
      require('runner').run_command(input)
    end
  end)
end, { desc = 'runner - run_command' })

map('n', '<leader>vL', function()
  require('runner').interrupt_runner()
  require('runner').run_last_command()
end, { desc = 'runner - interrupt_runner_and_run_last_command' })
-- }}}

-- vim:foldmethod=marker foldlevel=0
