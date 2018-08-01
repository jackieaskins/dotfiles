**\*\*Work in Progress\*\***

# My Dotfiles
My dotfiles for Vim, Zsh, and iTerm.

## Prerequisites
1. Vim must be installed
    - Find instructions for installing on your system here: https://www.vim.org/download.php
2. Zsh must be installed and set as your default shell: https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH
3. Oh-My-Zsh must be installed
    - Find installation instructions here: https://github.com/robbyrussell/oh-my-zsh
4. Powerline Fonts must be installed on your Host Machine: https://github.com/powerline/fonts

## Installation
1. Clone this repo:

   ```
   git clone https://github.com/jackieaskins/dotfiles.git ~/dotfiles
   ```

2. Run the install script:

   ```
   chmod +x ./install.sh
   ./install.sh
   ```

## Post-Installation
1. If you are using iTerm, configure it to load preferences from `~/dotfiles/iterm`
    - Go to iTerm2 > Preferences
    - Check under Preferences on the General Tab
    - Check the checkbox next to "Load preferences from a custom folder or URL" and fill in `~/dotfiles/iterm`

## Note
If you need to add Vim or Zsh specific content, you can create a file named `~/dotfiles/vim/custom.vim` or `~/dotfiles/zsh/custom.zsh` respectively. These files will be automatically sourced and ignored by Git.
