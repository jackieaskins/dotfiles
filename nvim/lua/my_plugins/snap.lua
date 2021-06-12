if vim.g.fuzzy_finder == 'snap' then
  local M = {}
  local snap = require 'snap'

  function M.ripgrep(query)
    snap.run {
      prompt = '>',
      producer = snap.get 'producer.ripgrep.vimgrep',
      select = snap.get'select.vimgrep'.select,
      multiselect = snap.get'select.vimgrep'.multiselect,
      views = {snap.get 'preview.vimgrep'},
      initial_filter = query,
    }
  end

  -- TODO: Git status & LSP provider
  snap.register.map({'n'}, {'<Leader>/'}, function() M.ripgrep('') end)
  snap.register.map({'n'}, {'<Leader>f'}, function() M.ripgrep(vim.fn.expand('<cword>')) end)
  snap.register.map({'n'}, {'<C-p>'}, function()
    snap.run {
      prompt = 'Files>',
      producer = snap.get 'consumer.fzf'(snap.get 'producer.ripgrep.file'),
      select = snap.get'select.file'.select,
      multiselect = snap.get'select.file'.multiselect,
      views = {snap.get 'preview.file'},
    }
  end)

  vim.cmd [[
    command! -nargs=* Rg lua require'my_plugins/snap'.ripgrep('<args>')
  ]]

  return M
end
