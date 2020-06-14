# Directory Navigation
# alias ls='ls --color=auto'
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
alias grh='git reset'
alias grhh='git reset --hard'
alias gst='git status'
alias gsta='git stash save'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsu='git submodule update --recursive'

# Dotfiles
alias dotfiles='cd ~/dotfiles'
alias sourcezsh='source ~/.zshrc'
alias zshconfig='vim ~/dotfiles/zshrc'
alias zshcustom='vim ~/dotfiles/zsh/custom.zsh'
alias vimconfig='vim ~/dotfiles/vim-common/config.vim'
alias vimplugins='vim ~/dotfiles/vim-common/plugins.vim'
alias vimcustom='vim ~/dotfiles/vim-common/custom.vim'

alias chrome='open -a "Google Chrome"'
