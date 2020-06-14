zsh_config=$HOME/dotfiles/zsh
export EDITOR='vim'

# Pure Prompt
fpath=(~/.zfunctions $fpath)
autoload -U promptinit; promptinit
prompt pure

for f in $zsh_config/*; do source $f; done
plugins=(zsh-autosuggestions zsh-syntax-highlighting)
for plugin in $plugins; do source $zsh_config/plugins/$plugin/$plugin.zsh; done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Use up & down arrows to iterate through commands starting with entered text
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
