# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 027

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# include user's private library paths for various scripting languages
PERL5LIB="$HOME/lib/perl5${PERL5LIB:+:$PERL5LIB}"
PERL5LIB="$HOME/lib/perl5/vendor_perl${PERL5LIB:+:$PERL5LIB}"
PERL5LIB="$HOME/lib/perl5/site_perl${PERL5LIB:+:$PERL5LIB}"
PYTHONPATH="$HOME/lib/python${PYTHONPATH:+:$PYTHONPATH}"
RUBYLIB="$HOME/lib/ruby${RUBYLIB:+:$RUBYLIB}"
export PERL5LIB PYTHONPATH RUBYLIB

# Configure personal RubyGems environment and add bin directory to PATH.
cmd='puts (defined?(RbConfig) ? RbConfig : Config)::CONFIG["ruby_version"]'
ver=$(ruby -rrbconfig -e "$cmd" 2> /dev/null)
if [ -n "$ver" ]; then
    GEM_HOME="$HOME/.gem/ruby/$ver"
    GEM_PATH="$GEM_HOME"
    export GEM_HOME GEM_PATH
fi
cmd='puts Gem.bindir'
dir=$(ruby -rrubygems -e "$cmd" 2> /dev/null)
if [ -n "$dir" ] && [ -d "$dir" ]; then
    # Make sure bin directory is not a duplicate in PATH.
    if ! echo "$PATH" | egrep '(^|:)'"$dir"'($|:)' > /dev/null 2>&1; then
	# Put this directory at the front of PATH, but after ~/bin if present.
	PATH=$(echo "$PATH" | sed -e 's,^\(.*'"$HOME/bin"':\)\?,\1'"$dir:,")
    fi
fi
unset cmd dir ver

# set default text editor, pager, and web browser
type vim > /dev/null 2>&1 && EDITOR=vim || EDITOR=vi
VISUAL=$EDITOR
type less > /dev/null 2>&1 && PAGER=less || PAGER=more
type w3m > /dev/null 2>&1 && BROWSER="${BROWSER:+$BROWSER:}w3m"
export EDITOR VISUAL PAGER
[ -n "$BROWSER" ] && export BROWSER
if [ "$PAGER" = less ]; then
    LESS=iFRSX
    MANPAGER='less -s'
    export LESS MANPAGER
fi
