if status is-interactive
    # Commands to run in interactive sessions can go here
end

set PATH $HOME/.jenv/bin $PATH
status --is-interactive; and source (jenv init -|psub)
pyenv init - fish | source


function restart_network
    echo "3-2" | sudo tee /sys/bus/usb/drivers/usb/unbind
    sleep 2
    echo "3-2" | sudo tee /sys/bus/usb/drivers/usb/bind
end
function updsys
	sudo apt update
	sudo apt full-upgrade
	sudo apt autoremove
	sudo apt autoclean
	sudo snap refresh
        sudo flatpak update
end

function ranger_cd
    set -l tempfile (mktemp)
    command ranger --choosedir=$tempfile $argv
    if test -f $tempfile
        set -l dir (cat $tempfile)
        if test -d "$dir"
            cd "$dir"
        end
        rm -f $tempfile
    end
end

function cl
        cd $argv
        ls
end

# Prompt
function fish_prompt
    set user (whoami)

    # Check if the current directory is within a Git repository
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        # Get the Git branch and other information, keep the inner parentheses
        set git_branch (fish_git_prompt)
        # Ensure only the branch name is wrapped in parentheses
        set git_info (string trim -c '()' $git_branch)")"
    end

    set_color cyan 
    echo -n (prompt_pwd)

    # If there's Git information, display it in green, followed by the prompt character
    if set -q git_info
        set_color green
        echo -n " $git_info"
    end

    set_color brblack
    echo -n ' Δ '
    
    # Reset color to normal and display the final $ symbol for the prompt
    set_color normal
    echo -n ' $ '
end

set -x ANDROID_HOME $HOME/.android/Sdk/
set -x PATH $PATH $ANDROID_HOME/platform-tools
set -x PATH $PATH $ANDROID_HOME/emulator
#set -x PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin/
#set -x PATH $PATH $ANDROID_HOME/ndk/27.1.12297006/ 
#set -x PATH $PATH $ANDROID_HOME/build-tools/36.0.0/ 

set -x PATH $PATH $HOME/.npm-global/bin 
set -x PATH $PATH $HOME/.bin

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

export LESSHISTFILE=-
export TERM="xterm-256color"
export VISUAL=nvim
export EDITOR=nvim
export ADB_LIBUSB=0 # uses native backend in ADB instead of libusb
export FLYCTL_INSTALL="/home/omar/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
export OLLAMA_HOST="127.0.0.1:11434"

alias autoremove='sudo pacman -Rscn $(pacman -Qdtq)'
alias vi='nvim'
alias vim='nvim'
alias nv='nvim' 
alias gc='git clone'
alias ..='cl ..'
alias la='ls -A'
alias gs='git status'
alias gp='git pull'
alias co='git checkout'
alias r='ranger_cd'
alias macos='cl /home/omar/Downloads/OSX-KVM'
alias repos='cl /home/omar/Downloads/repos'
alias docs='cl /home/omar/Documents'
alias h='cl $HOME'
alias chatbox='nohup /home/omar/.appImages/chatbox --no-sandbox > /home/omar/Downloads/chatbox.log 2>&1 & disown'

