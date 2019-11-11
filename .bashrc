# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

################################################
########........Increase history command history size........##########
################################################
HISTFILESIZE=1000000
HISTSIZE=1000000
PROMPT_COMMAND='history -a'

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[00;32m\]\u@\h\[\033[00m\]:\[\033[00;34m\]\w\[\033[00m\]\$ '
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

z=/3/00000000/songs

export PATH=${PATH}:~/bin
#to stop downloading the wallpapers comment out the below 
#xterm -bg "blue" -geometry 230x2+0+0 -fg "green" -fs 9 -cr "red" -e bash /home/v/wallp/dl.sh &
cd

#touch .wallprunning 

complete -d cd
complete -f vim


#bash .wallprunning.sh
alias ps1='PS1=$PS1"\e[7m"'
#PS1=$PS1"\e[1;37;40m"
sendtophone ()

{


while (( "$#" )); do

presentdir=`pwd`
dest=/tmp/"$(basename "$1")"
cp -v "$1" /tmp/"$(basename "$1")"


cd /tmp
basenameoffile="$(basename "$1")"

destination="./FROMPC/""$basenameoffile"


echo put \""$basenameoffile"\" \""$destination"\"| ftp -v 192.168.0.100 5544


cd "$presentdir"
shift 
done
}

#gmrun&
#gconftool-2 -s -t bool /apps/nautilus/preferences/show_desktop <span class="nb">false</span> &
#gconftool-2 -s -t bool /desktop/gnome/background/draw_background <span class="nb">false</span> &
#synapse&
#echo -e "Normal \e[7minverted"
#PS1="$PS1\033[36;40m"
#PS1="$PS1\e[7m"
#sudo /etc/init.d/openbsd-inetd restart
#GRUB_DEFAULT="\`more /home/the/reboottovalue && echo 0 > /home/the/reboottovalue\`"
#if [ -z "$DISPLAY" ] && [ $(tty) == /dev/tty1 ]; then
#    startx
#fi
#[ -f shutdown.sh ] && mv shutdown.sh shutdown.sha

exec bash $HOME/autonomousPLAYER/startup.sh &

#synclient TapButton1=1
# bash interact.sh && exit

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

bash autonomousPLAYER/interact.sh && exit
