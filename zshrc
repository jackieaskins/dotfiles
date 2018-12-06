export ZSH=~/.oh-my-zsh

# ZSH_THEME="agnoster-custom"
ZSH_THEME=""
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_CUSTOM=$HOME/dotfiles/zsh
plugins=(git rails zsh-autosuggestions zsh-syntax-highlighting shrink-path)

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'

# Pure Prompt
fpath=(~/.zfunctions $fpath)
autoload -U promptinit; promptinit
prompt pure

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
