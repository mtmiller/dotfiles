" Vim plugin for setting user preferences for indenting
" Maintainer:	Mike Miller <mtmiller@ieee.org>
" Last Change:	2012-01-27
" License:	Vim License

if &cp || exists("g:loaded_indentprefs_plugin")
  finish
endif
let g:loaded_indentprefs_plugin = 1

" Callable function to set user indentation preferences.  Inspired by
" Vim tip #83 at <http://vim.wikia.com/wiki/Indenting_source_code>.
function SetBufferIndentationPreferences(cols, ...)
  let l:option = a:0 ? a:1 : "default"
  let l:undo_ftplugin = "setl et< sw< sts< ts<"
  if l:option == "spaces"
    setlocal expandtab
    let &l:shiftwidth=a:cols
    let &l:softtabstop=a:cols
    setlocal tabstop&
  elseif l:option == "tabs"
    let &l:shiftwidth=a:cols
    let &l:tabstop=a:cols
    setlocal expandtab& softtabstop&
  else
    let &l:shiftwidth=a:cols
    let &l:softtabstop=a:cols
    setlocal expandtab& tabstop&
  endif
  if exists("b:undo_ftplugin")
    let b:undo_ftplugin = b:undo_ftplugin . " | " . l:undo_ftplugin
  else
    let b:undo_ftplugin = l:undo_ftplugin
  endif
endfunc
