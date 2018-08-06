export ZSH=~/.oh-my-zsh

ZSH_THEME="agnoster-custom"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_CUSTOM=$HOME/dotfiles/zsh
plugins=(git rails vundle shrink-path)

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'
