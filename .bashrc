HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n=> '
    # PS1='\u - \h - \w\n=> '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\n - $ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# alias
alias ll="ls -alF --color=always"

# path
export PATH=$PATH:/home/vincent/.local/bin

# config files
export XDG_CONFIG_HOME=$HOME/.config/


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# PS1='\[\e]0;\u@\h: \w\a\]\[\033[;32m\]┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)\[\033[;32m\])}(\[\033[1;32m\]\u@\h\[\033[;32m\])-[\[\033[0;34m\w\033[;32m\]]\n\[\033[;32m\]└─\[\033[1;34m\]\$\[\033[0m\] '
# PS1='\[\e]0;\u@\h: \w\a\]\[\033[;32m\]${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)\[\033[;32m\])}\[\033[1;32m\]\u@\h\[\033[;32m\]-[\[\033[0;34m\w\033[;32m\]]\n\[\033[;32m\] - \[\033[1;34m\]\$\[\033[0m\] '
# PS1="\[\]`export XIT=$? \ && [ ! -z "${GITHUB_USER}" ] && echo -n "\[\033[0;32m\]@${GITHUB_USER} " || echo -n "\[\033[0;32m\]\u " \ && [ "$XIT" -ne "0" ] && echo -n "\[\033[1;31m\]➜" || echo -n "\[\033[0m\]➜"` \[\033[1;34m\]\w `\ if [ "$(git config --get codespaces-theme.hide-status 2>/dev/null)" != 1 ]; then \ export BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null); \ if [ "${BRANCH}" != "" ]; then \ echo -n "\[\033[0;36m\](\[\033[1;31m\]${BRANCH}" \ && if git ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then \ echo -n " \[\033[1;33m\]✗"; \ fi \ && echo -n "\[\033[0;36m\]) "; \ fi; \ fi`\[\033[0m\]$ \[\]"

# rust - cargo
# . "$HOME/.cargo/env"

# [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}
