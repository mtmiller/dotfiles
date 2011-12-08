# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 027

# Add any missing standard directories to the end of PATH in order.
for dir in /usr/local/bin /usr/bin /bin /usr/local/games /usr/games; do
    if ! echo "$PATH" | egrep '(^|:)'"$dir"'($|:)' > /dev/null 2>&1; then
	PATH="$PATH:$dir"
    fi
done

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Configure user Perl library paths.
# Assume Perl modules are installed as perl Makefile.PL INSTALL_BASE=~ or
# perl Build.PL --install_base ~
for cmd in "print catdir('$HOME', qw(lib perl5))" \
           "print catdir('$HOME', qw(lib perl5), \$Config{archname})"; do
    dir=$(perl -MConfig -MFile::Spec::Functions -e "$cmd" 2> /dev/null)
    if [ -n "$dir" ]; then
	PERL5LIB="$dir${PERL5LIB:+:$PERL5LIB}"
	export PERL5LIB
    fi
done

# Configure user Python library paths.
# Assume Python packages are installed as python setup.py install --prefix=~
cmd="from distutils import sysconfig"
cmd="$cmd; print sysconfig.get_python_lib(0,0,prefix='$HOME')"
dir=$(python -c "$cmd" 2> /dev/null)
if [ -n "$dir" ]; then
    PYTHONPATH="$dir${PYTHONPATH:+:$PYTHONPATH}"
    export PYTHONPATH
fi

# Configure personal RubyGems environment and add bin directory to PATH.
cmd='puts (defined?(RbConfig) ? RbConfig : Config)::CONFIG["ruby_version"]'
ver=$(ruby -rrbconfig -e "$cmd" 2> /dev/null)
if [ -n "$ver" ]; then
    GEM_HOME="$HOME/.gem/ruby/$ver"
    GEM_PATH="$GEM_HOME"
    export GEM_HOME GEM_PATH
fi
cmd='puts Gem.default_dir'
dir=$(ruby -rrubygems -e "$cmd" 2> /dev/null)
if [ -n "$dir" ] && [ -d "$dir" ]; then
    GEM_PATH="${GEM_PATH:+$GEM_PATH:}$dir"
    export GEM_PATH
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

# Set default text editor, pager, and web browser.
for util in vimx vim vi ex ed; do
    type $util > /dev/null 2>&1 && EDITOR=$util && break
done
for util in vimx vim vi; do
    type $util > /dev/null 2>&1 && VISUAL=$util && break
done
for util in less more; do
    type $util > /dev/null 2>&1 && PAGER=$util && break
done
if [ -n "$DISPLAY" ]; then
    for util in google-chrome chromium-browser firefox; do
	type $util > /dev/null 2>&1 && BROWSER=$util && break
    done
fi
for util in w3m; do
    type $util > /dev/null 2>&1 && BROWSER="${BROWSER:+$BROWSER:}$util" && break
done
[ -n "$EDITOR"  ] && export EDITOR  || unset EDITOR
[ -n "$VISUAL"  ] && export VISUAL  || unset VISUAL
[ -n "$PAGER"   ] && export PAGER   || unset PAGER
[ -n "$BROWSER" ] && export BROWSER || unset BROWSER
unset util
if [ "$PAGER" = less ]; then
    LESS=iFRSX
    MANPAGER='less -s'
    export LESS MANPAGER
fi
if [ -n "$EDITOR" ]; then
    FCEDIT="$EDITOR"
    export FCEDIT
fi

# Include ~/.bashrc if this is a bash interactive login shell.
if [ -n "$PS1" ] && [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi
