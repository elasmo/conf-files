#  ~/.bashrc
#
# Globals
#export WECHALLTOKEN=""
#export WECHALLUSER=""
export EDITOR="vim"
export PAGER="less"
#export LSCOLORS="cxfxcxdxbxegedabagacad"
export LSCOLORS="Axfxcxdxbxegedabagacad"
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_NUMERIC="sv_SE.UTF-8"
export LC_MONETARY="sv_SE.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
#export LIBVIRT_DEFAULT_URI="qemu:///system"
export PROMPT_COMMAND='echo -ne "\e]0;${HOSTNAME}: ${DIRSTACK}\007"'
export PATH="${PATH}:~/bin:~/scripts"

# Return if not running interactively
#
case $- in
    *i*) ;;
    *) return;;
esac

# Prompt
#
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ $(/usr/bin/tput colors) -gt 0 ]; then
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='\[\e]0;\u@\h: \w\a\]\[\e[32;22;168m\]\h\[\e[00m\]:\[\e[0;31m\]\w\[\e[00m\] $ '
#PS1="\[\e[38;5;178m\]\h\[\e[00m\]:\[\e[0;33m\]\w\[\e[00m\] >"
#PS1="\[\033[3;32m\]\h\[\033[00m\]:\[\033[0;33m\]\w\[\033[00m\]>"
#PS1="\[\e[3;34m\]\h\[\e[00m\]:\[\e[0;33m\]\w\[\e[00m\] >"
#PS1="\[\e[3;31m\]\h\[\e[00m\]:\[\e[0;33m\]\w\[\e[00m\] >"
#PS1="\[\e[38;5;190m\]\h\[\e[00m\]:\[\e[0;31m\]\w\[\e[00m\] $"
#PS1="\[\e]0;\u@\h: \w\a\]\[\e[32;22;168m\]\h\[\e[00m\]:\[\e[0;31m\]\w\[\e[00m\] $"
else
	PS1='\h:\w $ '
fi
unset color_prompt force_color_prompt

# Aliases
#
case "$(uname -s)" in
    "OpenBSD")
        alias ls="colorls -G"
        alias pkglocate="pkg_info -Q"
        ;;
    "FreeBSD")
        alias ls="ls -GF" ;;
    "Linux")
        alias ls="ls --color"
        alias cal="ncal -bM"
        alias free="free -m"
        alias df="df -h"
        alias more="less"
        alias ip="ip -c"
        alias qemu-img="qemu-img -p"
        ;;
esac

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias ddate="date '+%y%m%d'"
alias week="date '+%V'"
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias calc="python3 -ic 'from math import *'"

# Key bindings
# 
# tcsh-style history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Command history
# 
HISTIGNORE=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# Completion
#
[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] && \
	source /usr/local/share/bash-completion/bash_completion.sh

for i in sudo doas man pkill killall; do
    complete -cf $i
done

# SSH agent
#
# https://stackoverflow.com/questions/18880024/start-ssh-agent-on-login
# http://mah.everybody.org/docs/ssh
#
#SSH_ENV="$HOME/.ssh/environment"
#
#function start_agent {
#    echo "Initialising new SSH agent..."
#    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
#    echo succeeded
#    chmod 600 "${SSH_ENV}"
#    . "${SSH_ENV}" > /dev/null
#    /usr/bin/ssh-add -s /usr/local/lib/pkcs11/opensc-pkcs11.so
#}
#
## Source SSH settings, if applicable
#if [ -f "${SSH_ENV}" ]; then
#    . "${SSH_ENV}" > /dev/null
#    ps -x | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#        start_agent;
#    }
#else
#    start_agent;
#fi

# Misc
#
# Make less more friendly for non-text input files, see lesspipe(1)             
[ -x /usr/bin/lesspipe.sh ] && eval "$(SHELL=/bin/sh lesspipe.sh)"              

shopt -s checkwinsize   # Update LINES and COLUMNS

urlencode() {
    echo -n $1 | xxd -plain | sed 's/\(..\)/%\1/g'
}

urldecode() {
    url="0:$(echo -n "$@" | sed 's/%/ /g')"
    echo $url | xxd -r
}

genrand() {
    [[ "$1" == "" ]] && nbytes=32 || nbytes=$1
    cat /dev/urandom | tr -dc '[:graph:]' | fold -w ${nbytes} | head -n 1
}
