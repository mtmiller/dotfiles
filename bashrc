# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Clear any aliases inherited from the system (no thank you, Red Hat)
unalias -a

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# set history length, save history to a file, and remember times for each
# history entry
HISTSIZE=1000
HISTFILE=~/.bash_history
HISTFILESIZE=1000
HISTTIMEFORMAT='%x %X '

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Fix TERM using helper command if available
type fix-term-env > /dev/null 2>&1 && eval `fix-term-env`

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
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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
    if [ -r ~/.dircolors ]; then
	# be backwards-compatible: attempt to detect keywords not understood by
	# the installed version of dircolors and filter them out
	errs=$(dircolors -b ~/.dircolors 2>&1 > /dev/null)
	bad=$(echo "$errs" | sed -n 's/^.*: unrecognized keyword \(.*\)$/\1/p')
	if [ "$bad" ]; then
	    filter='fgrep -v "$bad"'
	    # special case: if dircolors doesn't understand RESET fall back to
	    # using NORMAL and FILE
	    for word in $bad; do
		case "$word" in
		RESET) filter="sed 's/^RESET.*$/NORMAL 00\nFILE 00/' | $filter"
		esac
	    done
	    eval "$(cat ~/.dircolors | eval $filter | dircolors -b -)"
	else
	    eval "$(dircolors -b ~/.dircolors)"
	fi
	unset bad errs filter word
    else
	eval "$(dircolors -b)"
    fi
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

# enable programmable completion from ~/.bash_completion (needed for some
# systems where system-wide bash-completion is not installed).
if [ -f ~/.bash_completion ] && ! shopt -oq posix; then
    . ~/.bash_completion
fi

# Enable cdargs commands and completion if ~/.bash_cdargs is present.  The
# file can be copied from /usr/share/doc/cdargs/examples/cdargs-bash.sh in
# the cdargs package on a Debian system.  I prefer changing the name just so
# it is listed with other bash initialization files.  The Fedora cdargs
# package installs this file system-wide so this is not needed.
if [ -f ~/.bash_cdargs ]; then
    . ~/.bash_cdargs
fi
