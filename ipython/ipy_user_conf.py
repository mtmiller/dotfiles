# Configuration file for ipython version < 0.11.

import IPython
import IPython.ipapi
import ipy_defaults
import os
import sys


def unalias(shell, *args):
    """Remove aliases from the given IPython shell object."""
    for cmd in args:
        if cmd in shell.alias_table:
            del shell.alias_table[cmd]


def terminal_set_title(title):
    """Set the terminal title to the given string."""
    term = os.getenv('TERM')
    if term and term[0:5] == 'xterm':
        sys.stdout.write('\033]0;' + title + '\007')


def ipython_name_version():
    """Get the name and version of IPython."""
    s = 'IPython'
    if hasattr(IPython, '__version__'):
        s += ' ' + IPython.__version__
    return s


def import_future_feature(opts, *args):
    """Import future features into the IPython shell at startup."""
    import __future__
    for feature in args:
        if hasattr(__future__, feature):
            opts.autoexec.append('from __future__ import ' + feature)


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

    terminal_set_title(ipython_name_version())

    # Make ipython with python 2.x behave more like 3.x
    if int(sys.version[0]) < 3:
        import_future_feature(ip.options, 'division',
                                          'print_function',
                                          'unicode_literals')


main()
