#--------------------------------------------------------------------#
#                       Settings and Bindings                        #
#--------------------------------------------------------------------#

setopt auto_cd
setopt correct correctall

unsetopt BEEP

# Neovim as default editor
export VISUAL='nvim'
export EDITOR='nvim'

# Vi Mode
bindkey -v
export KEYTIMEOUT=1
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line

# History
export HISTORY_IGNORE="clear;*"
setopt appendhistory histignorealldups sharehistory histreduceblanks

#--------------------------------------------------------------------#
#                      ZSH Configuration Files                       #
#--------------------------------------------------------------------#

for f in $HOME/dotfiles/zsh/*; do source $f; done
