;; ~/.emacs

(when (fboundp 'blink-cursor-mode)
  (blink-cursor-mode 0))
(dolist (fn '(global-font-lock-mode show-paren-mode transient-mark-mode))
  (when (fboundp fn)
    (funcall fn t)))

(custom-set-variables
  '(diff-switches "-u")
  '(frame-title-format (concat  "%b - " (invocation-name) "@" (system-name)))
  '(require-final-newline 'query)
  '(ring-bell-function 'ignore)
  '(scroll-bar-mode 'right))
