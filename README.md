# My Dotfiles
My dotfiles for Vim, Zsh, and iTerm.

## Prerequisites
Ensure that the following are installed before beginning:

1. Vim: https://www.vim.org/download.php
1. Zsh (make sure it's set as your default shell): https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#how-to-install-zsh-on-many-platforms
1. Ripgrep: https://github.com/BurntSushi/ripgrep
1. NodeJS: https://nodejs.org/en/download/
1. Bat: https://github.com/sharkdp/bat#installation
1. Hack Nerd Font: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack

## Installation
1. Clone this repo:

   ```
   git clone --recurse-submodules https://github.com/jackieaskins/dotfiles.git ~/dotfiles
   ```

1. Run the install script:

   ```
   chmod +x ./install.sh
   ./install.sh
   ```

## Post-Installation
1. If you are using iTerm, configure it to load preferences from `~/dotfiles/iterm`
    - Go to iTerm2 > Preferences
    - Check under Preferences on the General Tab
    - Check the checkbox next to "Load preferences from a custom folder or URL" and fill in `~/dotfiles/iterm`
2. Navigate to the LSP submodules & run install instructions:
    - Sumneko Lua: https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
    - Eclipse JDTLS: https://github.com/eclipse/eclipse.jdt.ls#building-from-the-command-line

## Customization
To add machine-specific settings, create the files below. For:
- Vim: `~/dotfiles/vim-common/custom.vim`
- Zsh: `~/dotfiles/zsh/custom.zsh`

These files will be automatically sourced and ignored by Git.
