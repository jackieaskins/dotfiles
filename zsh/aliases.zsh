if type kitty &> /dev/null; then
  alias ssh='kitty +kitten ssh'
  alias icat='kitty +kitten icat'
fi

# Directory Navigation
alias -- -="cd -"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Git
alias g=git
alias ga='git add'
alias gb='git branch'
alias gbs='git bisect'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcb='git checkout -b'
alias gcl='git clone --recurse-submodules'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias glg='git log --stat'
alias glog='git log --oneline --decorate --graph'
alias gp='git push'
alias gre='git restore'
alias gres='git restore --staged'
alias grh='git reset'
alias grhh='git reset --hard'
alias gst='git status'
alias gsta='git stash push'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'
alias gsts='git stash show -p'
alias gsu='git submodule update --recursive'

# Dotfiles
alias dotfiles='cd ~/dotfiles'
alias sourcezsh='source ~/.zshrc'
alias zshaliases='nvim ~/dotfiles/zsh/aliases.zsh'
alias zshfuncs='nvim ~/dotfiles/zsh/functions.zsh'
alias zshconfig='nvim ~/dotfiles/zshrc'
alias zshcustom='nvim ~/dotfiles/zsh/custom.zsh'

alias chrome='open -a "Google Chrome"'
