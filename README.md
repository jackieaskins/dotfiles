# My Dotfiles

My dotfiles for Hammerspoon, Karabiner, Neovim, Nix, QMK, Tmux, WezTerm, and Zsh.

## Installation

1. On MacOS, install XCode developer tools:

   ```bash
   xcode-select --install 2> /dev/null
   ```

1. On Linux, set ZSH as the default shell:

   ```bash
   chsh -s /bin/zsh
   ```

1. Ensure `git` and `curl` are installed.

1. Install [Nix](https://nixos.org/download)

1. Close the shell and open a new one

1. Add custom configuration files to `~/dotfiles_custom` and add to git:

   - `nvim.lua`
   - `hammerspoon.lua`
   - `nix/configuration.nix`
     - On MacOS: `system.primaryUser` & `users.user.${primaryUser}.home`
   - `nix/home.nix`
     - At a minimum: `programs.git.settings.user.email` & `programs.git.settings.user.name`
     - On Linux: `home.username` & `home.homeDirectory`

1. Clone this repo:

   ```bash
   git clone https://github.com/jackieaskins/dotfiles.git ~/dotfiles
   ```

1. Run install script:

   ```bash
   ~/dotfiles/install.sh
   ```

1. Restart your device or log out and back in to ensure all settings are applied
