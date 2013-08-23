# Configuration file for ipython version >= 0.11.

import os
import sys

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

# Make ipython with python 2.x behave more like 3.x
if int(sys.version[0]) < 3:
    for feature in ('division', 'print_function', 'unicode_literals'):
        c.InteractiveShellApp.exec_lines.append('from __future__ import ' + feature)
