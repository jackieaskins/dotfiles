---@type LazySpec
return {
  'chrisgrieser/nvim-origami',
  event = 'VeryLazy',
  ---@module 'origami'
  ---@type Origami.config
  opts = {
    foldKeymaps = { setup = false },
    foldtext = {
      lineCount = { template = '󰘕 %d' },
    },
  },
}
