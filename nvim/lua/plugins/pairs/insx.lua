---@type LazySpec
return {
  'hrsh7th/nvim-insx',
  enabled = false,
  event = 'InsertEnter',
  config = function()
    local insx = require('insx')
    local auto_pair = require('insx.recipe.auto_pair')

    require('insx.preset.standard').setup()

    -- delete empty html tags
    insx.add(
      '<BS>',
      require('insx.recipe.substitute')({
        pattern = [[<\(\w\+\).\{-}>\%#</.\{-}>]],
        replace = [[\%#]],
      })
    )

    -- Nix overrides
    insx.add(
      '{',
      insx.with(auto_pair({ open = '{', close = '};' }), {
        insx.with.priority(10),
        insx.with.filetype({ 'nix' }),
        insx.with.match([[=.*\%#]]),
        insx.with.nomatch([[\$\%#]]),
      })
    )
    insx.add(
      '[',
      insx.with(auto_pair({ open = '[', close = '];' }), {
        insx.with.priority(10),
        insx.with.filetype({ 'nix' }),
      })
    )
    insx.add(
      '"',
      insx.with(auto_pair.strings({ open = '"', close = '";' }), {
        insx.with.priority(10),
        insx.with.filetype('nix'),
        insx.with.match([[=.*\%#]]),
        insx.with.nomatch([=[\[.*\%#]=]),
        insx.with.in_string(false),
        insx.with.in_comment(false),
      })
    )
  end,
}
