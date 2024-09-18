#--------------------------------------------------------------------#
#                                Brew                                #
#--------------------------------------------------------------------#

set -l brew_paths \
    /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew
for brew_path in $brew_paths
    if test -x $brew_path
        eval ($brew_path shellenv)
        break
    end
end
source (brew --prefix asdf)/libexec/asdf.fish

#--------------------------------------------------------------------#
#                                Path                                #
#--------------------------------------------------------------------#

fish_add_path -g ~/dotfiles/bin
fish_add_path -g ~/.cargo/bin
fish_add_path -g ~/.local/bin
fish_add_path -g ~/.yarn/bin
fish_add_path -g (ruby -e 'puts Gem.user_dir')/bin

if test -d ~/go
    set -gx GOPATH ~/go
    fish_add_path -g $GOPATH/bin
end

#--------------------------------------------------------------------#
#                               Editor                               #
#--------------------------------------------------------------------#

set -gx EDITOR nvim
set -gx VISUAL nvim

#--------------------------------------------------------------------#
#                           External Tools                           #
#--------------------------------------------------------------------#

set -gx FZF_DEFAULT_OPTS_FILE "$HOME/dotfiles/fzfrc"
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*" --glob "!*.class"'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

set -l fzf_kb_path "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.fish"
if test -e $fzf_kb_path
    source $fzf_kb_path

    if type -q fzf_key_bindings
        fzf_key_bindings
    end
end

if type -q wezterm
    wezterm shell-completion --shell fish | source
end

#--------------------------------------------------------------------#
#                              General                               #
#--------------------------------------------------------------------#

set -g fish_key_bindings fish_hybrid_key_bindings
set -g fish_greeting ''
starship init fish | source
