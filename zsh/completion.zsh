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

globalias() {
  zle _expand_alias
  zle self-insert
}
zle -N globalias

globaliasret() {
  zle _expand_alias
  zle accept-line
}
zle -N globaliasret

# space & enter expand all aliases, including global
bindkey -M emacs " " globalias
bindkey -M viins " " globalias
bindkey -M emacs "^M" globaliasret
bindkey -M viins "^M" globaliasret

# control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space

eval "$(zoxide init zsh --cmd cd)"
