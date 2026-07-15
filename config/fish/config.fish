if status is-interactive
    source (jenv init -|psub)
    #pyenv init - fish | source
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

function fish_prompt
    set -l last_status $status
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

    if test $last_status -ne 0
        set_color red
        echo -n " [$last_status]"
        set_color normal
    end
    
    # Reset color to normal and display the final $ symbol for the prompt
    set_color normal
    echo -n ' $ '
end

set -gx ANDROID_HOME $HOME/.android/Sdk/
#set -gx VOLTA_HOME "$HOME/.volta"

set PATH $HOME/.jenv/bin $PATH
set PATH $PATH $HOME/.bin 
#set PATH $PATH $HOME/.npm-global/bin 
#set PATH $PATH $HOME/.elan/bin

#set PATH $PATH $ANDROID_HOME/platform-tools
#set PATH $PATH $ANDROID_HOME/emulator
#set PATH $PATH $ANDROID_HOME/cmdline-tools/latest/bin/
#set PATH $PATH $ANDROID_HOME/ndk/27.1.12297006/ 
#set PATH $PATH $ANDROID_HOME/build-tools/36.0.0/ 

#set PATH "$VOLTA_HOME/bin" $PATH


export LESSHISTFILE=-
#export TERM="xterm-256color"
export VISUAL=nvim
export EDITOR=nvim
export ADB_LIBUSB=0 # uses native backend in ADB instead of libusb

alias vi='nvim'
alias vim='nvim'
alias nv='nvim' 
alias gc='git clone'
alias gs='git status'
alias gp='git pull'
alias co='git checkout'
alias ..='cl ..'
alias h='cl $HOME'
alias repos='cl $HOME/Downloads/repos'
alias la='ls -A'
alias r='ranger_cd'
alias printshellhist='cat ~/.local/share/fish/fish_history | grep \'cmd:\' | cut -d\' \' -f3-'
alias passwdgen='$HOME/.bin/hollow-noodle' 
alias autoremove='sudo pacman -Rscn $(pacman -Qdtq)'

