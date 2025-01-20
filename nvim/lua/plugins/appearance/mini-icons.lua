---@type LazySpec
return {
  'echasnovski/mini.icons',
  event = 'VeryLazy',
  opts = {
    default = {
      extension = { glyph = '' },
      file = { glyph = '' },
      filetype = { glyph = '' },
    },
    file = {
      fzfrc = { glyph = '󱡠', hl = 'MiniIconsAzure' },
      vimrc = { glyph = '', hl = 'MiniIconsGreen' },
      zshrc = { glyph = '', hl = 'MiniIconsGreen' },
      ['init.lua'] = { glyph = '󰢱', hl = 'MiniIconsAzure' },
    },
    filetype = {
      ghostty = { glyph = '󰊠', hl = 'MiniIconsBlue' },
      tmux = { glyph = '', hl = 'MiniIconsGreen' },
    },
  },
}
