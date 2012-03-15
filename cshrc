# ~/.cshrc: executed by csh(1) and tcsh(1) for login and non-login shells.

# force the umask in case it was changed by the system configuration
umask 027

# Clear any aliases inherited from the system (no thank you, Red Hat)
unalias *

if ($?tcsh && $?prompt) then

    if ( -r ~/.tcsh_editing ) then
        source ~/.tcsh_editing
    endif

    # make tcsh behavior a little closer to that of bash
    set symlinks = ignore
    set nonomatch

    set histdup = prev
    set history = (1000 "%h\t%W/%D/%Y %p\t%R\n")
    set savehist = (1000 merge)

    set prompt = "%n@%m:%~%# "
    set promptchars = '$#'

    if ($?TERM) then
        switch ($TERM)
        case xterm*:
            set prompt = "%{\033]0;%n@%m: %~\007%}$prompt"
            breaksw
        case screen*:
            set prompt = "%{\033_%n@%m: %~\033\\%}$prompt"
            breaksw
        endsw
    endif

    setenv COLUMNS
    setenv LINES
endif
