---@type LazySpec
return {
  'echasnovski/mini.icons',
  event = 'VeryLazy',
  config = function()
    require('mini.icons').setup({
      default = {
        extension = { glyph = '' },
        file = { glyph = '' },
        filetype = { glyph = '' },
      },
      file = {
        vimrc = { glyph = '', hl = 'MiniIconsGreen' },
        zshrc = { glyph = '', hl = 'MiniIconsGreen' },
        ['init.lua'] = { glyph = '󰢱', hl = 'MiniIconsAzure' },
      },
      filetype = {
        kitty = { glyph = '󰄛', hl = 'MiniIconsOrange' },
        tmux = { glyph = '', hl = 'MiniIconsGreen' },
      },
    })
    MiniIcons.mock_nvim_web_devicons()
  end,
}
