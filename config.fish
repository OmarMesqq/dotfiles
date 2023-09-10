if status is-interactive
    # Commands to run in interactive sessions can go here
end

# cd and auto ls
function cl
   cd $argv
   ls  
end

# Prompt
function fish_prompt 
	set_color purple 
	echo (prompt_pwd) '$' (set_color normal)
end


export LESSHISTFILE=-
export TERM="xterm-256color"
alias vi='vim'
alias fs='killall stremio && killall node'
alias ..='cl ..'
alias r='ranger'
alias c='clear'
alias la='ls -A'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#if test -f /home/omar/.mambaforge/bin/conda
#    eval /home/omar/.mambaforge/bin/conda "shell.fish" "hook" $argv | source
#end
# <<< conda initialize <<<

