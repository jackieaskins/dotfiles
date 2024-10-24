# Courtesy of https://thevaluable.dev/zsh-completion-guide-examples/

zstyle ':completion:*' completer _extensions _complete _approximate

zstyle ':completion:*' list-prompt ''
zstyle ':completion:*' matcher-list 'l:|=* r:|=*'

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "~/.cache/zsh/.zcompcache"

zstyle ':completion:*' menu select

zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

zstyle ':completion:*' group-name ''

zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' complete-options true

zstyle ':completion:*:default' list-colors ''

zmodload zsh/complist

bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey -M menuselect '^N' menu-complete
bindkey -M menuselect '^P' reverse-menu-complete

autoload -Uz compinit; compinit

expand-alias-and-self-insert() {
  zle _expand_alias
  zle self-insert
}
zle -N expand-alias-and-self-insert

expand-alias-and-accept-line() {
  zle _expand_alias
  zle accept-line
}
zle -N expand-alias-and-accept-line
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(expand-alias-and-accept-line)

# space & enter expand all aliases, including global
bindkey -M emacs " " expand-alias-and-self-insert
bindkey -M viins " " expand-alias-and-self-insert
bindkey -M emacs "^M" expand-alias-and-accept-line
bindkey -M viins "^M" expand-alias-and-accept-line

# control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space
