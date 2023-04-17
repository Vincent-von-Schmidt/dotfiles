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
export PATH=/home/vincent/.codon/bin:$PATH

# starship
eval "$(starship init zsh)"
STARSHIP_CONFIG=~/.config/starship.toml

# alias
alias ll="ls -alF --color=always" 
alias tree="tree -a"
alias update="sudo apt update && sudo apt upgrade -y"
alias mail="neomutt"

# auto tmux
[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}
