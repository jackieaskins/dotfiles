# My Dotfiles
My dotfiles for Vim, Neovim, Zsh, Tmux, and Kitty.

![Kitty terminal with Neovim editor inside Tmux session](https://github.com/jackieaskins/dotfiles/blob/media/kitty.png?raw=true)

## Installation
1. Clone this repo:

   ```bash
   git clone https://github.com/jackieaskins/dotfiles.git ~/dotfiles
   ```

2. Run the install script:

   ```bash
   ./install.sh
   ```

## Customization
To add machine-specific settings, create the files below. For:
- Vim: `~/dotfiles/vim/custom.vim`
- Neovim:
    - `~/dotfiles/nvim/lua/custom.lua` - General settings
    - `~/dotfiles/nvim/lua/custom/plugins.lua` - Custom plugins
    - `~/dotfiles/nvim/lua/custom/lspconfig.lua` - Custom LSP configs
- Tmux: `~/dotfiles/tmux/custom.conf`
- Zsh: `~/dotfiles/zsh/custom.zsh`

These files are automatically sourced and ignored by Git.
