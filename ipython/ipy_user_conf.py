# Configuration file for ipython version < 0.11.

import IPython.ipapi
import ipy_defaults
import os
import sys


def unalias(shell, *args):
    """Remove aliases from the given IPython shell object."""
    for cmd in args:
        if cmd in shell.alias_table:
            del shell.alias_table[cmd]


def main():
    """Configure IPython shell for versions < 0.11."""
    ip = IPython.ipapi.get()
    ip.options.autoindent = 1
    ip.options.confirm_exit = 0
    ip.options.pprint = 1
    ip.options.separate_out = ''

    unalias(ip.IP, 'lc', 'lf', 'lk', 'll', 'lx', 'ddir', 'ldir')
    if os.name == 'posix':
        ip.defalias('ps', 'ps')
        if 'bsd' in sys.platform:
            ip.defalias('ls', 'colorls -G')
        else:
            ip.defalias('ls', 'ls --color=auto')


main()
