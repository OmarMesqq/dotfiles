if status is-interactive
    # Commands to run in interactive sessions can go here
end

set PATH $HOME/.jenv/bin $PATH
status --is-interactive; and source (jenv init -|psub)

status --is-interactive; and source (rbenv init -|psub)

function cl
        cd $argv
        ls
end

function updsys 
    sudo apt update
    sudo apt full-upgrade
    sudo apt autoremove
    sudo apt autoclean
    sudo snap refresh
end

function extract
    set extracted_folder $(uuidgen)
    set extracted_folder $(string sub --length 8 $extracted_folder)
    set extracted_folder $(string join '' "extracted_" $extracted_folder)
    mkdir $extracted_folder
    mv $argv[1] $extracted_folder
    cl $extracted_folder
    unzip $argv[1]
end

# Prompt
function fish_prompt
    set user (whoami)
    set host (hostname)

    # Check if the current directory is within a Git repository
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        # Get the Git branch and other information, keep the inner parentheses
        set git_branch (fish_git_prompt)
        # Ensure only the branch name is wrapped in parentheses
        set git_info (string trim -c '()' $git_branch)")"
    end

    # Set prompt color and display the username@hostname, followed by the current directory
    set_color purple
    echo -n "$user@$host: "(prompt_pwd)

    # If there's Git information, display it in green, followed by the prompt character
    if set -q git_info
        set_color green
        echo -n " $git_info"
    end

    # Reset color to normal and display the final $ symbol for the prompt
    set_color normal
    echo -n ' $ '
end

set -x ANDROID_HOME $HOME/.android/Sdk/
set -x PATH $PATH $ANDROID_HOME/platform-tools
set -x PATH $PATH $ANDROID_HOME/emulator
set -x PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin/
set -x PATH $PATH $HOME/bin
set -x PATH $PATH $HOME/.flutter/flutter/bin

export CHROME_EXECUTABLE="/snap/bin/chromium"
export LESSHISTFILE=-
export TERM="xterm-256color"
export VISUAL=nvim
export EDITOR=nvim

alias vi='nvim'
alias vim='nvim'
alias nv='nvim' 
alias gc='git clone'
alias ..='cl ..'
alias la='ls -A'
alias gs='git status'
alias gp='git pull'
alias co='git checkout'
alias macos='cl /home/omar/hdd/vm/MacOS/OSX-KVM && ./OpenCore-Boot.sh'
alias repos='cl /home/omar/Downloads/repos'
alias scripts='cl /home/omar/Downloads/scripts'

# Update terminal title to include user@host:current directory
function update_terminal_title --on-event fish_prompt
    echo -ne "\e]0; (whoami)@(hostname): (prompt_pwd)\a"
end

# Adjust LINES and COLUMNS after resizing the terminal
function check_window_size --on-event fish_prompt
    set -l term_dims (stty size | string split " ")
    set -gx LINES $term_dims[1]
    set -gx COLUMNS $term_dims[2]
end

# Bind the check_window_size function to trigger after every command
function fish_postexec --on-event fish_postexec
    check_window_size
end
