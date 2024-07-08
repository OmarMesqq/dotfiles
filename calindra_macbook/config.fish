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

function git_email_prompt
    set git_email (git config --get user.email 2>/dev/null)
    switch $git_email
        case 'omar.mesquita-terceiro@cea.com.br'
            echo "C&A mail"
        case 'omar.mesquita@calindra.com.br'
            echo "Calindra mail"
    	case 'omarmsqt@gmail.com'
		echo "GitHub mail"
    	case '*'
            echo "unknown mail"
    end
end


function fish_prompt
    # Check if the current directory is within a Git repository
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        # Get the Git branch information
        set git_info (fish_git_prompt)
        # Get the Git email information
        set git_email_info (git_email_prompt)

        # Display Git info if available
        if set -q git_info
            echo -n "$git_info"
            if set -q git_email_info
                set_color red
                echo " [$git_email_info]"
                set_color normal
            else
                echo ""
            end
        end
    end

    # Display the current directory
    set_color purple
    echo (prompt_pwd)

    # Reset color to normal and display the final $ symbol for the prompt
    set_color normal
    echo -n '$ '
end
set -x ANDROID_HOME /Users/omar/Library/Android/sdk
set -x PATH $PATH $ANDROID_HOME/platform-tools
set -x PATH $PATH $ANDROID_HOME/emulator
set -x PATH $ANDROID_HOME/tools/bin $PATH

export LESSHISTFILE=-
export VISUAL=nvim
export EDITOR=nvim
export RANGER_LOAD_DEFAULT_RC="FALSE"
export VOLTA_HOME="$HOME/.volta"

alias vi='nvim'
alias vim='nvim'
alias nv='nvim' 
alias gc='git clone'
alias ..='cl ..'
alias r='ranger_cd'
alias c='clear'
alias la='ls -A'
