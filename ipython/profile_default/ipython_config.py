# Configuration file for ipython version >= 0.11.

import os
import sys

c = get_config()

c.TerminalIPythonApp.ignore_old_config = True
c.InteractiveShell.autoindent = True
c.InteractiveShell.colors = 'Linux'
c.InteractiveShell.confirm_exit = False

c.AliasManager.default_aliases = []
c.AliasManager.user_aliases = []
if os.name == 'posix':
    c.AliasManager.user_aliases.append(('ps', 'ps'))
    if 'bsd' in sys.platform:
        c.AliasManager.user_aliases.append(('ls', 'colorls -G'))
    else:
        c.AliasManager.user_aliases.append(('ls', 'ls --color=auto'))
