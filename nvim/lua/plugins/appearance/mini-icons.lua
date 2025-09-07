---@type LazySpec
return {
  'nvim-mini/mini.icons',
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
      tmux = { glyph = '', hl = 'MiniIconsGreen' },
      fugitive = { glyph = '󰊢', hl = 'MiniIconsGreen' },
    },
  },
}
