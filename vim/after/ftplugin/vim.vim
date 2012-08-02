" Vim filetype plugin
" Language:	Vim

call SetBufferIndentationPreferences(2, "spaces")

" Use Vim internal help for keyword lookup
setlocal keywordprg=:help
let b:undo_ftplugin = b:undo_ftplugin . " | setl kp<"
