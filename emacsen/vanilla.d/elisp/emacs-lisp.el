;;; emacs-lisp

(use-package lispxmp
  :commands lispxmp)

(use-package nameless
  :hook
  (emacs-lisp-mode . nameless-mode))

(use-package evil-lisp-state)

(use-package overseer)

(use-package lispy :disabled
  :hook
  (emacs-lisp-mode . lispy-mode)
  (lisp-interaction-mode . lispy-mode))

;; keybindings
(progn
  (defvar my/emacs-lisp-mode-map (make-sparse-keymap))
  (defvar my/emacs-lisp-mode-eval-map (make-sparse-keymap))

  (general-def
    my/emacs-lisp-mode-eval-map
    "e" #'eval-last-sexp
    "b" #'eval-buffer
    "f" #'eval-defun
    "r" #'eval-region)

  (general-def
    my/emacs-lisp-mode-map
    "'"  #'ielm
    "e"  #'(:keymap my/emacs-lisp-mode-eval-map :wk "eval")
    "h"  #'helpful-at-point
    "c"  #'(emacs-lisp-byte-compile :wk "byte-compile")
    "x"  #'lispxmp)

  (general-def
    '(normal visual)
    (emacs-lisp-mode-map lisp-interaction-mode-map)
    "," #'(:keymap my/emacs-lisp-mode-map)))
