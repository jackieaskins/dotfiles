-- https://github.com/kyazdani42/nvim-web-devicons

local web_devicons = require('nvim-web-devicons')
local colors = require('colors')

web_devicons.setup({
  default = false,
})

local brewfile_icon, brewfile_color = web_devicons.get_icon_color('Brewfile')
local vim_icon, vim_color = web_devicons.get_icon_color('vim')
local zsh_icon, zsh_color = web_devicons.get_icon_color('zsh')

web_devicons.set_icon({
  Brewfile_personal = {
    icon = brewfile_icon,
    color = brewfile_color,
    name = 'Brewfile_personal',
  },
  vimrc = {
    icon = vim_icon,
    color = vim_color,
    name = 'Vim',
  },
  zshrc = {
    icon = zsh_icon,
    color = zsh_color,
    name = 'Zsh',
  },
  NvimTree = {
    icon = '',
    color = colors.green,
    name = 'NvimTree',
  },
})
