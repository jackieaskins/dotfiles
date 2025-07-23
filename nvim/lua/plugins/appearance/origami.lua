---@type LazySpec
return {
  'chrisgrieser/nvim-origami',
  event = 'VeryLazy',
  ---@module 'origami'
  ---@type Origami.config
  opts = {
    foldtext = {
      lineCount = { template = '󰘕 %d' },
    },
  },
}
