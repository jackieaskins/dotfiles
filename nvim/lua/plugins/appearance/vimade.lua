---@type LazySpec
return {
  'TaDaa/vimade',
  event = 'VeryLazy',
  opts = {
    blocklist = {
      default = {
        highlights = { 'NvimSeparator' },
      },
    },
    recipe = { 'duo', { animate = true } },
  },
}
