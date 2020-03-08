# My Dotfiles
My dotfiles for Vim, Zsh, and iTerm.

## Prerequisites
Ensure that the following are installed before beginning:

1. Vim: https://www.vim.org/download.php
2. Zsh (make sure it's set as your default shell): https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH
3. Oh-My-Zsh: https://github.com/robbyrussell/oh-my-zsh
4. The Silver Searcher (Ag): https://github.com/ggreer/the_silver_searcher#installing
5. NodeJS: https://nodejs.org/en/download/
6. Universal Ctags: https://github.com/universal-ctags/ctags#the-latest-build-and-package

## Installation
1. Clone this repo:

   ```
   git clone --recurse-submodules https://github.com/jackieaskins/dotfiles.git ~/dotfiles
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
2. :CocInstall the following extensions:
    - [coc-marketplace](https://github.com/fannheyward/coc-marketplace) - List of extensions available within CoC
    - [coc-emmet](https://github.com/neoclide/coc-emmet) - View emmet completions in suggestions
    - [coc-inline-jest](https://github.com/khanghoang/coc-jest) - Jest testing framework integration
    - [coc-json](https://github.com/neoclide/coc-json) - JSON support
    - [coc-tags](https://github.com/neoclide/coc-sources) - Support for tags as a source
    - [coc-tsserver](https://github.com/neoclide/coc-tsserver) - JavaScript & Typescript support
    - [coc-yaml](https://github.com/neoclide/coc-yaml) - Yaml support

## Customization
To add machine-specific settings, create the files below. For:
- Vim Plugins: `~/dotfiles/vim/custom_plugins.vim`
- General Vim: `~/dotfiles/vim/custom.vim`
- Zsh: `~/dotfiles/zsh/custom.zsh`

These files will be automatically sourced and ignored by Git.
