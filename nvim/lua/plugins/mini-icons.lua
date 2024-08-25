return {
  'echasnovski/mini.icons',
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
    })
    MiniIcons.mock_nvim_web_devicons()
  end,
}
