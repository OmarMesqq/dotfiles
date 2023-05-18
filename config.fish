if status is-interactive
    # Commands to run in interactive sessions can go here
end

# cd and auto ls
function cl
   cd $argv
   ls  
end

export LESSHISTFILE=-

alias ..='cl ..'
alias r='ranger'
alias c='clear'
alias la='ls -A'
