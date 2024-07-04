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
      },
      filetype = {
        TelescopePrompt = { glyph = '', hl = 'MiniIconsBlue' },

        -- Workaround: Mini lowercases filetype
        nvimtree = { glyph = '󰙅', hl = 'MiniIconsGreen' },
        telescopeprompt = { glyph = '', hl = 'MiniIconsBlue' },
      },
    })
    MiniIcons.mock_nvim_web_devicons()
  end,
}
