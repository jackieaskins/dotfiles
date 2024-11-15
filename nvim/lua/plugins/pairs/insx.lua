---@type LazySpec
return {
  'hrsh7th/nvim-insx',
  event = 'InsertEnter',
  config = function()
    require('insx.preset.standard').setup()

    -- delete empty html tags
    require('insx').add(
      '<BS>',
      require('insx.recipe.substitute')({
        pattern = [[<\(\w\+\).\{-}>\%#</.\{-}>]],
        replace = [[\%#]],
      })
    )
  end,
}
