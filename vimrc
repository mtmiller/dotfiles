" ~/.vimrc: initialize Vim to behave like Vim or vi depending on the
" compiled-in feature set and how it was invoked.
"
" Copyright (C) 2011 Mike Miller
" License: GPL-3+
"
" - If vim is tiny or small, configure like vi.
" - If vim is invoked as ex, vi, or view, configure like vi.
" - Otherwise, bootstrap vimrc_normal.vim to configure Vim.
"
if v:progname != 'ex' && v:progname !~ '^vi\(ew\)\?$'
  runtime vimrc_normal.vim
  finish
endif
" If this file is still sourcing, Vim is tiny or small or was invoked as
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
set shortmess+=I		" Disable Vim splash screen.
set t_AB= t_AF= t_Sb= t_Sf=	" Disable terminal color escape codes.
source $HOME/.exrc		" Execute commands from ~/.exrc.
