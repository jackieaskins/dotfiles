#--------------------------------------------------------------------#
#                       Homebrew Configuration                       #
#--------------------------------------------------------------------#

brew_paths=(/usr/local/bin/brew /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew)
for brew_path in $brew_paths
do
  if [[ -x $brew_path ]]; then
    eval "$($brew_path shellenv)"
    break
  fi
done

fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)

asdf_prefix="$(brew --prefix asdf)"
[ -d $asdf_prefix ] && . $asdf_prefix/libexec/asdf.sh

#--------------------------------------------------------------------#
#                                Path                                #
#--------------------------------------------------------------------#

[ -d $HOME/.cargo/bin ] && path+=($HOME/.cargo/bin)
[ -d $HOME/dotfiles/bin ] && path+=($HOME/dotfiles/bin)
[ -d $HOME/.local/bin ] && path+=($HOME/.local/bin)
path+=("$(ruby -e 'puts Gem.user_dir')/bin")

if [ -d $HOME/go ]; then
  export GOPATH=$HOME/go
  path+=($GOPATH/bin)
fi

export PATH

#--------------------------------------------------------------------#
#                               Prompt                               #
#--------------------------------------------------------------------#

eval "$(starship init zsh)"

#--------------------------------------------------------------------#
#                       Settings and Bindings                        #
#--------------------------------------------------------------------#

setopt auto_cd
setopt correct correctall

unsetopt BEEP

# Neovim as default editor
export VISUAL='nvim'
export EDITOR='nvim'

# Vi Mode
bindkey -v
export KEYTIMEOUT=1
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line

# History
export HISTFILE=~/.zsh_history
export HISTFILESIZE=10000
export HISTSIZE=10000
export SAVEHIST=10000
export HISTORY_IGNORE="clear;*"
setopt appendhistory histignorealldups sharehistory histreduceblanks

# Color ls output
export CLICOLOR="Yes"

#--------------------------------------------------------------------#
#                              Plugins                               #
#--------------------------------------------------------------------#

# https://github.com/zsh-users/zsh-autosuggestions
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# https://github.com/zsh-users/zsh-syntax-highlighting
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#--------------------------------------------------------------------#
#                             Scrollback                             #
#--------------------------------------------------------------------#

function clear-scrollback-buffer {
  # Behavior of clear:
  # 1. clear scrollback if E3 cap is supported (terminal, platform specific)
  # 2. then clear visible screen
  # For some terminal 'e[3J' need to be sent explicitly to clear scrollback
  clear && printf '\e[3J'
  # .reset-prompt: bypass the zsh-syntax-highlighting wrapper
  # https://github.com/sorin-ionescu/prezto/issues/1026
  # https://github.com/zsh-users/zsh-autosuggestions/issues/107#issuecomment-183824034
  # -R: redisplay the prompt to avoid old prompts being eaten up
  # https://github.com/Powerlevel9k/powerlevel9k/pull/1176#discussion_r299303453
  zle && zle .reset-prompt && zle -R
}
zle -N clear-scrollback-buffer
bindkey '^L' clear-scrollback-buffer

#--------------------------------------------------------------------#
#                    External Tools Configuration                    #
#--------------------------------------------------------------------#

# FZF
export FZF_DEFAULT_OPTS_FILE="$HOME/dotfiles/fzfrc"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!*.class"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[[ $- == *i* ]] && source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" 2> /dev/null
source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"

export EZA_ICONS_AUTO=on

#--------------------------------------------------------------------#
#                      ZSH Configuration Files                       #
#--------------------------------------------------------------------#

for f in $HOME/dotfiles/zsh/*; do source $f; done
