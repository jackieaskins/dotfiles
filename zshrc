export ZSH=~/.oh-my-zsh

# ZSH_THEME="agnoster-custom"
ZSH_THEME=""
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_CUSTOM=$HOME/dotfiles/zsh
plugins=(git zsh-autosuggestions zsh-syntax-highlighting shrink-path)

source $ZSH/oh-my-zsh.sh
command -v nvim &> /dev/null && alias vim=nvim
export EDITOR='vim'

# Pure Prompt
fpath=(~/.zfunctions $fpath)
autoload -U promptinit; promptinit
prompt pure

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
