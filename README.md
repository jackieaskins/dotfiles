# My Dotfiles
My dotfiles for Vim, Zsh, and iTerm.

## Prerequisites
Ensure that the following are installed before beginning:

1. Vim: https://www.vim.org/download.php
1. Zsh (make sure it's set as your default shell): https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#how-to-install-zsh-on-many-platforms
1. The Silver Searcher (Ag): https://github.com/ggreer/the_silver_searcher#installing
1. NodeJS: https://nodejs.org/en/download/
1. Universal Ctags: https://github.com/universal-ctags/ctags#the-latest-build-and-package

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

## Customization
To add machine-specific settings, create the files below. For:
- Vim: `~/dotfiles/vim-common/custom.vim`
- Zsh: `~/dotfiles/zsh/custom.zsh`

These files will be automatically sourced and ignored by Git.
