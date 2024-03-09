return {
  'nvim-tree/nvim-web-devicons',
  config = function()
    local web_devicons = require('nvim-web-devicons')

    web_devicons.setup({ default = false })

    local all_icons = web_devicons.get_icons()

    web_devicons.set_icon({
      gomod = all_icons.go,
      mod = all_icons.go,
      vimrc = all_icons.vim,
      zshrc = all_icons.zsh,
      TelescopePrompt = { icon = '', name = 'Telescope' },
      NvimTree = { icon = '󰙅', name = 'NvimTree' },
    })
  end,
}
