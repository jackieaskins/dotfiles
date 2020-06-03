export ZSH=~/.oh-my-zsh

ZSH_THEME=""
ZSH_CUSTOM=$HOME/dotfiles/zsh
plugins=(git zsh-autosuggestions zsh-syntax-highlighting shrink-path vi-mode)
export KEYTIMEOUT=1

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'

# Pure Prompt
fpath=(~/.zfunctions $fpath)
autoload -U promptinit; promptinit
prompt pure

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
