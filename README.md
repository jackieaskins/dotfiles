# My Dotfiles
My dotfiles for Neovim 0.5, Vim, Zsh, and iTerm/Kitty.

## Installation
1. Clone this repo:

   ```
   git clone https://github.com/jackieaskins/dotfiles.git ~/dotfiles
   ```

2. Run the install script:

   ```
   ./install.sh
   ```

## Customization
To add machine-specific settings, create the files below. For:
- Vim: `~/dotfiles/vim/custom.vim`
- Neovim: `~/dotfiles/nvim/lua/custom.lua`
- Tmux: `~/dotfiles/tmux/custom.conf`
- Zsh: `~/dotfiles/zsh/custom.zsh`

These files are automatically sourced and ignored by Git.
