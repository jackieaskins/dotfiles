zsh_config=$HOME/dotfiles/zsh
export EDITOR='nvim'

# Vi Mode
bindkey -v
export KEYTIMEOUT=1

bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line

fpath=(~/.zfunctions $fpath)

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
zstyle :compinstall filename '${HOME}/dotfiles/zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Pure Prompt
autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:git:stash show yes

RPROMPT='[%D{%L:%M:%S %p}]'

# General Options
setopt auto_cd
setopt correct correctall

# History
export HISTFILE=~/.zsh_history
export HISTFILESIZE=10000
export HISTSIZE=10000
export SAVEHIST=10000

setopt appendhistory histignorealldups sharehistory histreduceblanks

# Use up & down arrows to iterate through commands starting with entered text
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Color ls output
export CLICOLOR="Yes"

# Load zsh config files
for f in $zsh_config/*; do source $f; done

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!*.class"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bindkey "ç" fzf-cd-widget
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export BAT_THEME="base16"

export PATH=$PATH:$HOME/dotfiles/bin

# Load plugins
# zsh-syntax-highlighting must be the last thing sourced in the zshrc
plugins=(zsh-autosuggestions zsh-syntax-highlighting)
for plugin in $plugins; do source $zsh_config/plugins/$plugin/$plugin.zsh; done
