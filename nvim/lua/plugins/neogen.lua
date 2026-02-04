---@type LazySpec
return {
  'danymat/neogen',
  cmd = 'Neogen',
  config = function()
    require('neogen').setup({
      snippet_engine = require('utils').get_snippet_engine(),
    })
  end,
}
