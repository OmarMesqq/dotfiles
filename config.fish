if status is-interactive
    # Commands to run in interactive sessions can go here
end

function ranger_cd
    ranger --choosedir=/tmp/rangerdir $argv
    if test -e /tmp/rangerdir
        set DIR (cat /tmp/rangerdir)
        cl $DIR
        rm -f /tmp/rangerdir
    end
end

function cl
        cd $argv
        ls
end

# Prompt
function fish_prompt
    # Check if the current directory is within a Git repository
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        # Get the Git branch and other information, keep the inner parentheses
        set git_branch (fish_git_prompt)
        # Ensure only the branch name is wrapped in parentheses
        set git_info (string trim -c '()' $git_branch)")" 
    end

    # Set prompt color and display the current directory
    set_color purple
    echo -n (prompt_pwd)

    # If there's Git information, display it in green, followed by the prompt character
    if set -q git_info
        set_color green
        echo -n " $git_info"
    end

    # Reset color to normal and display the final $ symbol for the prompt
    set_color normal
    echo -n ' $ '
end


export LESSHISTFILE=-
export TERM="xterm-256color"
export VISUAL=nvim
export EDITOR=nvim
export RANGER_LOAD_DEFAULT_RC="FALSE"

alias vi='nvim'
alias vim='nvim'
alias fs='killall stremio && killall node'
alias ..='cl ..'
alias r='ranger_cd'
alias c='clear'
alias la='ls -A'
