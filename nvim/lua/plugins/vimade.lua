---@type LazySpec
return {
  'TaDaa/vimade',
  event = 'VeryLazy',
  config = function()
    require('vimade').setup({
      recipe = { 'duo', { animate = true } },
      blocklist = {
        committia = {
          buf_name = {
            '__committia_diff__',
            '__committia_status__',
          },
        },
        win_separator = {
          highlights = { 'WinSeparator' },
        },
      },
    })
  end,
}
