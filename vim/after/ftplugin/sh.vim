" Vim filetype plugin
" Language:	Shell

call SetBufferIndentationPreferences(4, "spaces")
if v:version >= 700
  let b:sh_indent_options = {"case-labels": 0}
  let b:undo_ftplugin .= " | unlet! b:sh_indent_options"
endif
