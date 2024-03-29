# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/vincent/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# path
export PATH=/snap/bin:$PATH

# starship
eval "$(starship init zsh)"
STARSHIP_CONFIG=~/.config/starship.toml

# alias
alias ll="ls -alF --color=always" 
alias tree="tree -a"
alias home="cd /mnt/c/Users/Vincent/"
alias v="fzf | xargs nvim {}"

# config files
export XDG_CONFIG_HOME=$HOME/.config/
export WIN_HOME=/mnt/c/Users/Vincent/

# auto tmux
[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}
