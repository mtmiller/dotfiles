# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

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
