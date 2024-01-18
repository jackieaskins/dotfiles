# My Dotfiles

My dotfiles for Hammerspoon, Karabiner, kitty, Neovim, Vim, QMK, Tmux, WezTerm, and Zsh.

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
 
### Hammerspoon

Return a `table` in `~/dotfiles/hammerspoon/custom.lua`, the following keys can be provided:
- `brewPrefix` - `string`
- `appKeys` - `table<string, string>`
- `twmWindowFilters` - `table<string, boolean | table>`
    - See [setFilters](https://www.hammerspoon.org/docs/hs.window.filter.html#setFilters)
- `twmScreenPadding` - `number`
- `twmWindowGap` - `number`

### Neovim

Use the following files to customize Neovim:
- General settings: `~/dotfiles/nvim/lua/custom.lua`
- Custom plugins: `~/dotfiles/nvim/lua/plugins/custom-[plugin-name].lua`
- Custom LSP configs: `~/dotfiles/nvim/lua/custom/lspconfig.lua`
- Custom GX matchers: `~/dotfiles/nvim/lua/custom/gx-matchers.lua` 

#### Overriding Supported LSP Servers

To override the list of supported LSP servers, add the following global variables to `~/dotfiles/nvim/lua/custom.lua`:
- `vim.g.additional_server_commands` - Table from server name to install command, used to add support for installing additional servers. See `~/dotfiles/nvim/lua/lsp/servers.lua` for install command references.
- `vim.g.supported_servers` - List of server names to override the default list of supported servers. Ensure any additional servers are added to this list.

### Tmux

`~/dotfiles/tmux/custom.conf`

### Vim

`~/dotfiles/vim/custom.vim`

### WezTerm
Return a table in  `~/dotfiles/wezterm/custom.lua`, the following keys can be provided:
- `workspaces` - `table<string, Workspace>`

### Zsh

`~/dotfiles/zsh/custom.zsh`
