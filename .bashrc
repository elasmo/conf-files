#  ~/.bashrc
#
# Globals
#export WECHALLTOKEN=""
#export WECHALLUSER=""
export EDITOR="vim"
export PAGER="less"
export LSCOLORS="cxfxcxdxbxegedabagacad"
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_NUMERIC="sv_SE.UTF-8"
export LC_MONETARY="sv_SE.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LIBVIRT_DEFAULT_URI="qemu:///system"
export PROMPT_COMMAND='echo -ne "\e]0;${HOSTNAME}: ${DIRSTACK}\007"'
export PATH="${PATH}:~/bin:~/scripts"

# Prompt
declare -A custom_prompt
    custom_prompt[cobia]="\[\e[38;5;178m\]\h\[\e[00m\]:\[\e[0;33m\]\w\[\e[00m\] >"
    custom_prompt[sturgeon]="\[\033[3;32m\]\h\[\033[00m\]:\[\033[0;33m\]\w\[\033[00m\]>"
    custom_prompt[minnow]="\[\e[3;34m\]\h\[\e[00m\]:\[\e[0;33m\]\w\[\e[00m\] >"
    custom_prompt[shiner]="\[\e[3;31m\]\h\[\e[00m\]:\[\e[0;33m\]\w\[\e[00m\] >"
    custom_prompt[prsm]="\[\e[38;5;190m\]\h\[\e[00m\]:\[\e[0;31m\]\w\[\e[00m\] $"
    custom_prompt[papaya]="\[\e]0;\u@\h: \w\a\]\[\e[32;22;168m\]\h\[\e[00m\]:\[\e[0;31m\]\w\[\e[00m\] $"

case "${TERM}" in
    xterm-256color|rxvt-256color)
        export PS1="${custom_prompt[$(hostname -s)]} "
        ;;
    *)
        export PS1="\h:\w$ "
        ;;
esac

unset $custom_prompt

# Aliases
#
if [ $(uname) == "FreeBSD" ]; then
    alias ls='ls -GF'
elif [ $(uname) == "Linux" ]; then
    alias ls='ls --color'
fi

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ddate="date '+%Y%m%d%'"
alias mdate="date '+%Y-%m-%d%'"
alias cdate="date '+%Y%m%d%H%M%S'"
alias tn='tmux new -s'
alias ta='tmux attach -t'

# Key bindings
# 
# tcsh-style history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Command history
# 
HISTCONTROL=ignoreboth  # clean history
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend # append

# Bash completion
# 
[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] && \
	source /usr/local/share/bash-completion/bash_completion.sh

# Misc
#
# Make less more friendly for non-text input files, see lesspipe(1)             
[ -x /usr/bin/lesspipe.sh ] && eval "$(SHELL=/bin/sh lesspipe.sh)"              

# Check the window size after each command and, if necessary,                   
# update the values of LINES and COLUMNS.                                       
shopt -s checkwinsize                 

# Encode text to hex
urlencode() {
    echo -n $1 | xxd -plain | sed 's/\(..\)/%\1/g'
}
