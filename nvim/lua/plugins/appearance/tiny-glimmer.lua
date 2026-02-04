---@type LazySpec
return {
  'rachartier/tiny-glimmer.nvim',
  event = 'VeryLazy',
  config = function()
    require('tiny-glimmer').setup({
      overwrite = {
        paste = { enabled = true },
        redo = { enabled = true },
        search = { enabled = true },
        undo = { enabled = true },
      },
    })
  end,
}
