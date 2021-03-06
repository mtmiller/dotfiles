# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Load common shell initializations
if [ -r ~/.shrc ]; then
    . ~/.shrc
fi

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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
screen*)
    PS1="\[\e_${debian_chroot:+($debian_chroot)}\u@\h: \w\e\\\\\]$PS1"
    ;;
*)
    ;;
esac

# Enable color support in ls if the shell is on a valid terminal.
case "$TERM" in
""|dumb)
    ;;
*)
    # GNU ls and dircolors are both part of coreutils, prefer this option.
    # Fall back to colorls for *BSD.
    if [ -x /usr/bin/dircolors ]; then
        case "$TERM" in
        *256col*) fn=~/.dircolors-256color ;;
        *)        fn=~/.dircolors ;;
        esac
        if [ "$TMUX" ]; then
            fn=~/.dircolors-256color
        fi
        if [ ! -r $fn ]; then
            fn=~/.dircolors
        fi
        if [ -r $fn ]; then
            # be backwards-compatible: attempt to detect newer keywords not
            # understood by the available version of dircolors and filter
            # them out
            errs=$(dircolors -b $fn 2>&1 > /dev/null)
            bad=$(echo "$errs" | sed -n 's/^.*: unrecognized keyword \(.*\)$/\1/p')
            if [ "$bad" ]; then
                fix='grep -F -v "$bad"'
                # special cases:
                # - if dircolors doesn't know RESET, use NORMAL and FILE
                # - if dircolors doesn't know OTHER_WRITABLE, remove SET[GU]ID
                for word in $bad; do
                    case "$word" in
                    RESET) fix="sed 's/^RESET.*$/NORMAL 00\nFILE 00/' | $fix" ;;
                    *OTHER*) fix="grep -v 'SET[GU]ID' | $fix" ;;
                    esac
                done
                eval "$(cat $fn | eval $fix | dircolors -b -)"
            else
                eval "$(dircolors -b $fn)"
            fi
            unset bad errs fix word
        else
            eval "$(dircolors -b)"
        fi
        unset fn
        alias ls='ls --color=auto'

        case "$TERM" in
        *256col*)
            GREP_COLOR="01;38;5;196"
            GREP_COLORS="ms=01;38;5;196:mc=01;38;5;196:sl=:cx=:fn=38;5;139"
            GREP_COLORS="$GREP_COLORS:ln=38;5;117:bn=38;5;117:se=38;5;37"
            ;;
        *)
            GREP_COLOR="01;31"
            GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=34:bn=34:se=36"
            ;;
        esac
        if [ "$TMUX" ]; then
            GREP_COLOR="01;38;5;196"
            GREP_COLORS="ms=01;38;5;196:mc=01;38;5;196:sl=:cx=:fn=38;5;139"
            GREP_COLORS="$GREP_COLORS:ln=38;5;117:bn=38;5;117:se=38;5;37"
        fi
        export GREP_COLOR GREP_COLORS
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    elif type colorls > /dev/null 2>&1; then
        alias ls='colorls -G'
    fi
    ;;
esac

# Define command aliases to invoke the preferred editor and pager utilities.
# Use the sensible-utils commands if on Debian; otherwise, use the values of
# standard variables.
if type sensible-editor > /dev/null 2>&1; then
    alias editor=sensible-editor
    alias e=sensible-editor
    alias v=sensible-editor
elif [ -n "${VISUAL:-$EDITOR}" ]; then
    alias editor="${VISUAL:-$EDITOR}"
    alias e="${VISUAL:-$EDITOR}"
    alias v="${VISUAL:-$EDITOR}"
fi
if type sensible-pager > /dev/null 2>&1; then
    alias pager=sensible-pager
elif [ -n "$PAGER" ]; then
    alias pager="$PAGER"
fi

# Compensate for Red Hat installing the most featureful Vim under a
# different name.
if type vimx > /dev/null 2>&1; then
    alias vim=vimx
fi

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
