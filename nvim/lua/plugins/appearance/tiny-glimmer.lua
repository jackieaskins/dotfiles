---@type LazySpec
return {
  'rachartier/tiny-glimmer.nvim',
  event = 'VeryLazy',
  opts = {
    overwrite = {
      paste = { enabled = true },
      redo = { enabled = true },
      search = { enabled = true },
      undo = { enabled = true },
    },
  },
}
