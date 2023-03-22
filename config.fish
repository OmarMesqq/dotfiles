if status is-interactive
    # Commands to run in interactive sessions can go here
end

# cd and auto ls
function cl
   cd $argv
   ls  
end


alias ..='cl ..'
alias r='ranger'
alias rm='echo Instead, use del'
alias del='trash-put'
alias c='clear'
