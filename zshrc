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

#--------------------------------------------------------------------#
#                                Path                                #
#--------------------------------------------------------------------#
[ -d $HOME/.cargo/bin ] && path+=($HOME/.cargo/bin)
[ -d $HOME/go/bin ] && path+=($HOME/go/bin)
path+=($HOME/dotfiles/bin)
export PATH

#--------------------------------------------------------------------#
#                             Completion                             #
#--------------------------------------------------------------------#
# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
zstyle :compinstall filename '${HOME}/dotfiles/zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#--------------------------------------------------------------------#
#                               Prompt                               #
#--------------------------------------------------------------------#
autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:git:stash show yes

RPROMPT='[%D{%L:%M:%S %p}]'

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
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!*.class"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export BAT_THEME="base16"

#--------------------------------------------------------------------#
#                      ZSH Configuration Files                       #
#--------------------------------------------------------------------#
for f in $HOME/dotfiles/zsh/*; do source $f; done

#--------------------------------------------------------------------#
#                              Plugins                               #
#--------------------------------------------------------------------#
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History substring search must come after syntax highlighting
source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
