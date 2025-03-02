---@type LazySpec
return {
  'TaDaa/vimade',
  event = 'VeryLazy',
  opts = {
    recipe = { 'duo', { animate = true } },
    blocklist = {
      committia = {
        buf_name = {
          '__committia_diff__',
          '__committia_status__',
        },
      },
    },
  },
}
