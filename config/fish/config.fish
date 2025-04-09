if status is-interactive
    # Commands to run in interactive sessions can go here
end

set PATH $HOME/.jenv/bin $PATH
status --is-interactive; and source (jenv init -|psub)
status --is-interactive; and source (rbenv init -|psub)
pyenv init - fish | source


function trash
    set -l trash_dir "$HOME/.local/share/Trash/files"
    mkdir -p "$trash_dir"
    
    for file in $argv
        if test -e "$file"
            mv "$file" "$trash_dir"/
        else
            echo "File '$file' not found" >&2
        end
    end
end

function rm --description 'Alias rm to trash, ignoring flags'
    trash $argv
end

function ranger_cd
    set -l tempfile (mktemp)
    command ranger --choosedir=$tempfile $argv
    if test -f $tempfile
        set -l dir (cat $tempfile)
        if test -d "$dir"
            cd "$dir"
        end
        /usr/bin/rm -f $tempfile
    end
end

function restart_network
    echo "4-1" | sudo tee /sys/bus/usb/drivers/usb/unbind
    sleep 2
    echo "4-1" | sudo tee /sys/bus/usb/drivers/usb/bind
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

    # Reset color to normal and display the final $ symbol for the prompt
    set_color normal
    echo -n ' $ '
end

set -x ANDROID_HOME $HOME/.android/Sdk/
set -x PATH $PATH $ANDROID_HOME/platform-tools
set -x PATH $PATH $ANDROID_HOME/emulator
set -x PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin/
set -x PATH $PATH $HOME/.rbenv/shims 
set -x PATH $PATH $HOME/.npm-global/bin 
set -x PATH $PATH $HOME/.bin 
# for aapt
set -x PATH $PATH $ANDROID_HOME/build-tools/36.0.0/

export LESSHISTFILE=-
export TERM="xterm-256color"
export VISUAL=nvim
export EDITOR=nvim
export _JAVA_AWT_WM_NONREPARENTING=1

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
alias macos='cl /home/omar/repos/sequoia_OSX-KVM && ./OpenCore-Boot.sh'
