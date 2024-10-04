#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cl ..'
alias c='clear'
alias r='ranger'

cl() {
    if [ -n "$1" ]; then
        cd "$1" && ls
    else
        cd && ls
    fi
}

PS1='[\u@\h \W]\$ '

unset HISTFILE 
