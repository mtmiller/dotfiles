" ~/.vimrc: initialize Vim to behave like Vim or vi depending on the
" compiled-in feature set and how it is invoked.
"
" Copyright (C) 2011 Mike Miller
" License: GPL-3+
"
" Intended behavior:
" - If Vim is tiny or small, configure like vi.
" - If Vim is invoked as ex, vi, or view, configure like vi.
" - Otherwise, bootstrap vimrc_normal.vim to configure Vim.
"
" First fix some things that may be inherited from buggy system vimrc
" configuration files, for either Vim or vi.
" - Restore the default file character encoding list, see :help fencs.
if v:lang =~ 'utf8$' || v:lang =~ 'UTF-8$'
  set fileencodings=ucs-bom,utf-8,default,latin1
endif
" - Remove unwanted and just plain broken autocommands (sorry, Red Hat).
if has('autocmd')
  augroup fedora
  autocmd!
  augroup! fedora
  augroup redhat
  autocmd!
  augroup! redhat
  augroup END
  autocmd!
endif
" If the command name is not ex, vi, or view, turn control over to
" vimrc_normal.vim.  If Vim is compiled with the tiny or small set of
" features, the if..endif will be skipped over as well.
if v:progname != 'ex' && v:progname !~ '^vi\(ew\)\?$'
  runtime vimrc_normal.vim
  finish
endif
" If this file is still sourcing, Vim is tiny or small or is invoked as
" ex, vi, or view.
" - Turn off automatic file type detection.
if has('autocmd')
  filetype off
  filetype plugin indent off
endif
" - Turn off syntax highlighting.
if has('syntax')
  syntax off
endif
" - Set/reset editor options for vi compatibility.
set compatible			" Revert to vi-compatible mode.
set cpoptions+={\|&/\\.		" Enable POSIX vi compatibility.
set cedit& viminfo&		" Clear options not reset by above.
set noloadplugins		" Disable startup loading of plugins.
set shortmess+=I		" Disable Vim splash screen.
set t_AB= t_AF= t_Sb= t_Sf=	" Disable terminal color escape codes.
source $HOME/.exrc		" Execute commands from ~/.exrc.
