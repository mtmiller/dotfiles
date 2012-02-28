" vimrc_normal.vim: executed by Vim from ~/.vimrc during initialization.
"
" Maintainer:		Mike Miller
" Original Author:	Bram Moolenaar <Bram@vim.org>
" Last Change:		2011-02-28
"
" Install in the runtime path (e.g. ~/.vim) to be found by ~/.vimrc.
" This file is sourced only for Vim normal, big, or huge.

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim" || v:progname =~? "eview"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set shortmess+=I	" don't display the Vim intro at startup
set laststatus=2	" always show the status line

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Extend the runtimepath using the pathogen plugin.
" http://github.com/tpope/vim-pathogen
let s:pluginpath = 'pathogen#'
if v:version >= 700
  call {s:pluginpath}runtime_append_all_bundles()
  call {s:pluginpath}helptags()
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcNormal
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Prefer a dark background on terminal emulators.
if &term =~ "^xterm"
  set background=dark
  set t_Co=16
endif

" User customizations for syntax highlighting.
if has("syntax")
  let g:is_posix = 1
  if v:version < 700
    let g:is_kornshell = 1
  endif
  let g:fortran_fixed_source = 1
  let g:fortran_have_tabs = 1
endif

" Settings specific to using the GUI.
if has("gui")

  " Fonts to use in gvim.  Always have fallbacks, and handle each platform in
  " its own special way, see :help setting-guifont.
  if has("gui_gtk2")
    set guifont=Liberation\ Mono\ 10,Monospace\ 10
  elseif has("x11")
    set guifont=-*-lucidatypewriter-medium-r-normal-*-*-120-*-*-m-*-*
  elseif has("gui_win32")
    set guifont=Lucida_Console:h9:cANSI,Courier_New:h9:cANSI,Terminal:h9
  endif

  " GUI customizations.  No blinking cursor, no tearoffs, no toolbar.
  set guicursor=a:blinkon0
  set guioptions-=tT

  " The following settings must be done when the GUI starts.
  augroup guiInitCommands
  au!

  " Load my favorite color scheme by default.
  autocmd GUIEnter * colorscheme zenburn

  " Override default less options for a chance of working in the GUI
  " (e.g. :shell command or man page lookup)
  autocmd GUIEnter * let $LESS = $LESS . 'dr'
  augroup END

endif
