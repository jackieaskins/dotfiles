#--------------------------------------------------------------------#
#                       Homebrew Configuration                       #
#--------------------------------------------------------------------#
if [[ -d /opt/homebrew ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  brew_path="$(which brew)"
  eval "$($brew_path shellenv)"
fi
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
autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:git:stash show yes

RPROMPT='%F{'#6E738D'}[%D{%L:%M:%S %p}]'

#--------------------------------------------------------------------#
#                       Settings and Bindings                        #
#--------------------------------------------------------------------#
setopt auto_cd
setopt correct correctall

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

# https://github.com/marlonrichert/zsh-autocomplete
source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# Tab and Shift-Tab move the selection in the menu
bindkey              '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select
# Make Ctrl-N and Ctrl-P behave like Tab/Shift-Tab
bindkey -M menuselect '^N' menu-complete
bindkey -M menuselect '^P' reverse-menu-complete
bindkey '^N' menu-complete
bindkey '^P' reverse-menu-complete
bindkey '^N' menu-select
bindkey '^P' menu-select
# Left and Right Arrows always move cursor in comand line
bindkey -M menuselect '^[[D' .backward-char '^[OD' .backward-char
bindkey -M menuselect '^[[C' .forward-char '^[OC' .forward-char
# Enter always submits the command line
bindkey -M menuselect '^M' .accept-line
# Match all substrings, not just prefixes
zstyle ':completion:*' matcher-list 'r:|?=**'
bindkey '\e[A' .history-search-backward
bindkey '\e[B' .history-search-forward

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
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!*.class"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

[[ $- == *i* ]] && source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" 2> /dev/null
source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"

#--------------------------------------------------------------------#
#                      ZSH Configuration Files                       #
#--------------------------------------------------------------------#
for f in $HOME/dotfiles/zsh/*; do source $f; done
