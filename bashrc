unset HISTFILE
export LESSHISTFILE=-

cl() {
	cd $@ 
	ls 
}

alias fs='killall stremio && killall node'
alias cd='cl'
alias ..='cl ..'
alias r='ranger' 
alias c='clear'
alias la='ls -A' 
