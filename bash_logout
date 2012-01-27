# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    if [ -x /usr/bin/clear_console ]; then
	/usr/bin/clear_console -q
    else
	# don't bother clearing a pseudo-terminal
	case `tty` in
	/dev/pts/*) ;;
	/dev/tty[p-zP-Za-eA-E][0-9A-Za-z]) ;;
	*)          [ -x /usr/bin/clear ] && /usr/bin/clear ;;
	esac
    fi
fi
