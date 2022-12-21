local M = { 'nvim-tree/nvim-web-devicons' }

function M.config()
  local web_devicons = require('nvim-web-devicons')

  web_devicons.setup({
    default = false,
  })

  local brewfile_icon, brewfile_color, brewfile_cterm_color = web_devicons.get_icon_color('Brewfile')
  local vim_icon, vim_color, vim_cterm_color = web_devicons.get_icon_color('vim')
  local zsh_icon, zsh_color, zsh_cterm_color = web_devicons.get_icon_color('zsh')
  local go_icon, go_color, go_cterm_color = web_devicons.get_icon_color('go')

  web_devicons.set_icon({
    Brewfile_personal = {
      icon = brewfile_icon,
      color = brewfile_color,
      cterm_color = brewfile_cterm_color,
      name = 'Brewfile_personal',
    },
    gomod = {
      icon = go_icon,
      color = go_color,
      cterm_color = go_cterm_color,
      name = 'Gomod',
    },
    mod = {
      icon = go_icon,
      color = go_color,
      cterm_color = go_cterm_color,
      name = 'Gomod',
    },
    vimrc = {
      icon = vim_icon,
      color = vim_color,
      cterm_color = vim_cterm_color,
      name = 'Vim',
    },
    zshrc = {
      icon = zsh_icon,
      color = zsh_color,
      cterm_color = zsh_cterm_color,
      name = 'Zsh',
    },
    ['neo-tree filesystem [1]'] = {
      icon = '',
      color = '#358a5b',
      name = 'NeoTree',
    },
    lazy = {
      icon = '',
      color = '#dea584',
      name = 'Lazy',
    },
  })
end

return M
