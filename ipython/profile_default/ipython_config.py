# Configuration file for ipython version >= 0.11.

import IPython
import os
import sys


def terminal_set_title(title):
    """Set the terminal title to the given string."""
    term = os.getenv('TERM')
    if term and term[0:5] == 'xterm':
        sys.stdout.write('\033]0;' + title + '\007')


def ipython_name_version():
    """Get the name and version of IPython."""
    s = "IPython"
    if hasattr(IPython, '__version__'):
        s += ' ' + IPython.__version__
    return s


c = get_config()

c.TerminalIPythonApp.ignore_old_config = True
c.InteractiveShell.autoindent = True
c.InteractiveShell.colors = 'Linux'
c.InteractiveShell.confirm_exit = False
c.InteractiveShellApp.exec_lines = []

c.AliasManager.default_aliases = []
c.AliasManager.user_aliases = []
if os.name == 'posix':
    c.AliasManager.user_aliases.append(('ps', 'ps'))
    if 'bsd' in sys.platform:
        c.AliasManager.user_aliases.append(('ls', 'colorls -G'))
    else:
        c.AliasManager.user_aliases.append(('ls', 'ls --color=auto'))

terminal_set_title(ipython_name_version())

# Make ipython with python 2.x behave more like 3.x
if int(sys.version[0]) < 3:
    for feature in ('division', 'print_function', 'unicode_literals'):
        c.InteractiveShellApp.exec_lines.append('from __future__ import ' + feature)
