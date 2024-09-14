# My Dotfiles

My dotfiles for Hammerspoon, Karabiner, kitty, Neovim, Vim, QMK, Tmux, WezTerm, and Zsh.

![Image showcasing current setup](https://github.com/jackieaskins/dotfiles/blob/media/setup.png?raw=true)

## Installation

1. Clone this repo:

    ```bash
    git clone https://github.com/jackieaskins/dotfiles.git ~/dotfiles
    ```

1. Run the install script:

    ```bash
    ./install.sh
    ```

## Customization
 
### Hammerspoon

Return a `table` in `~/dotfiles/hammerspoon/custom.lua`, the following keys can be provided:
- `appKeys` - `table<string, string>`
- `twmWindowFilters` - `table<string, boolean | table>`
    - See [setFilters](https://www.hammerspoon.org/docs/hs.window.filter.html#setFilters)
- `twmScreenPadding` - `number`
- `twmWindowGap` - `number`

### Neovim

Use the following files to customize Neovim:
- General settings: `~/dotfiles/nvim/lua/custom.lua`
- Custom plugins: `~/dotfiles/nvim/lua/plugins/custom/`

#### Configuration Variables

The list of supported configuration variables can be found at the top of `~/dotfiles/nvim/lua/config_variables.lua`
- To override the default values of these settings, set them in `~/dotfiles/nvim/lua/custom.lua`

### Tmux

`~/dotfiles/tmux/custom.conf`

### Vim

`~/dotfiles/vim/custom.vim`

### Zsh

`~/dotfiles/zsh/custom.zsh`
