# My Dotfiles
My dotfiles for Yabai, Karabner, Hammerspoon, SketchyBar, Vim, Neovim, Zsh, Tmux, and kitty.

![Image showcasing current setup](https://github.com/jackieaskins/dotfiles/blob/media/setup.png?raw=true)

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

### Overriding Supported LSP Servers
The following global variables can be used to override the list of supported LSP servers:

* `vim.g.additional_server_commands` - Table from server name to install command, used to add support for installing additional servers. See `~/dotfiles/nvim/lua/lsp/servers.lua` for install command references.
* `vim.g.supported_servers` - List of server names to override the default list of supported servers. Ensure any additional servers are added to this list.

These variables can be added to `~/dotfiles/nvim/lua/custom.lua`.
