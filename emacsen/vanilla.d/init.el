;;; core

;; straight.el and core libraries
(progn
  (defvar bootstrap-version)
  (let ((bootstrap-file (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
        (bootstrap-version 5))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
          (url-retrieve-synchronously
           "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
           'silent 'inhibit-cookies)
        (goto-char (point-max))
        (eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage))

  (straight-use-package 'use-package)
  ;; (setq straight-vc-git-default-protocol "https") ; https or ssh
  (setq straight-use-package-by-default t)

  (use-package dash)
  (use-package f)
  (use-package s))

;; load private libraries
(progn
  (load (expand-file-name "~/Dropbox/repos/github/five-dots/dotfiles/emacsen/elisp/const.el"))
  (load (expand-file-name "const-secret.el" my/elisp-dir))
  (load (expand-file-name "vars.el" my/elisp-dir))
  (load (expand-file-name "funcs.el" my/elisp-dir))
  ;; ;; core
  (load (expand-file-name "elisp/core.el" user-emacs-directory))
  (load (expand-file-name "elisp/evil.el" user-emacs-directory))
  (load (expand-file-name "elisp/fold.el" user-emacs-directory))
  (load (expand-file-name "elisp/ui.el" user-emacs-directory))
  (load (expand-file-name "elisp/treemacs.el" user-emacs-directory))
  ;; auto completion
  (load (expand-file-name "elisp/ivy.el" user-emacs-directory))
  (load (expand-file-name "elisp/company.el" user-emacs-directory))
  (load (expand-file-name "elisp/snippet.el" user-emacs-directory))
  ;; shel
  (load (expand-file-name "elisp/eshell.el" user-emacs-directory))
  ;; programming tools
  (load (expand-file-name "elisp/vc.el" user-emacs-directory))
  (load (expand-file-name "elisp/flycheck.el" user-emacs-directory))
  (load (expand-file-name "elisp/lsp.el" user-emacs-directory))
  ;; lang
  (load (expand-file-name "elisp/org.el" user-emacs-directory))
  (load (expand-file-name "elisp/emacs-lisp.el" user-emacs-directory))
  (load (expand-file-name "elisp/ess.el" user-emacs-directory))
  (load (expand-file-name "elisp/stan.el" user-emacs-directory))
  (load (expand-file-name "elisp/python.el" user-emacs-directory))
  (load (expand-file-name "elisp/csharp.el" user-emacs-directory))
  ;; misc
  (load (expand-file-name "elisp/misc.el" user-emacs-directory))
  (load (expand-file-name "elisp/japanese.el" user-emacs-directory)))


;;; keybindings

;; Use osx command as meta
(when my/mac-p
  (setq mac-command-modifier 'meta))

;; evil states
(progn
  (general-def
    '(normal visual)
    ;; fold
    ;; TODO should use '(motion global)
    "za" #'my/fold-toggle
    "zc" #'my/fold-close
    "zo" #'my/fold-open
    "zO" #'my/fold-open
    "zm" #'my/fold-close-all
    "zr" #'my/fold-open-all
    "zj" #'my/fold-next
    "zk" #'my/fold-previous
    "zf" #'evil-vimish-fold/create
    "zF" #'evil-vimish-fold/create-line
    "zd" #'vimish-fold-delete
    "zE" #'vimish-fold-delete-all

    "C-M-," #'centaur-tabs-backward
    "C-M-." #'centaur-tabs-forward))

;; my/window-map
(progn
  (defvar my/window-map (copy-keymap evil-window-map))

  (general-unbind
    'my/window-map
    "C-S-h"
    "C-S-j"
    "C-S-k"
    "C-S-l"
    "C-S-r"
    "C-r"
    "C-S-s"
    "C-s"
    "C-v"
    "S"
    "C-S-w"
    "C-_"
    "C-b"
    "C-c"
    "C-f"
    "C-n"
    "C-o"
    "C-p"
    "C-t"
    "C-w"
    "c"
    "s"
    "v"
    "w"
    "W")

  ;; TODO hydra for window manipulation
  (general-def
    'my/window-map
    "-" #'(my/evil-window-split-and-focus :wk "horizontal-split")
    "/" #'(my/evil-window-vsplit-and-focus :wk "vertical-split")
    "s" #'(my/evil-window-split-and-focus :wk "horizontal-split")
    "v" #'(my/evil-window-vsplit-and-focus :wk "vertical-split")
    "d" #'evil-window-delete
    "w" #'ace-window
    "m" #'(ace-swap-window :which-key "swap-window")))

;; my/help-map
(progn
  (defvar my/help-map (copy-keymap help-map))

  (general-unbind
    'my/help-map
    "<f1>"
    "<help>"
    "?"
    "C-\\"
    "C-n")

  (general-def
    'my/help-map
    [remap describe-key] #'helpful-key))

;; leader map
(progn
  ;; TODO pretty-hydra

  ;; search
  (defvar my/search-map (make-sparse-keymap))
  (general-def
    my/search-map
    "b" #'swiper
    "B" #'swiper-all
    "g" #'google-this
    ;; "d" #'(my/search-dir :which-key "search-dir")
    ;; "D" #'(my/search-other-dir :which-key "search-other-dir")
    )

  ;; app
  (defvar my/app-map (make-sparse-keymap))
  (general-def
    my/app-map
    "u" #'(undo-tree-visualize :wk "undo-tree"))

  ;; buffer
  (defvar my/buffer-map (make-sparse-keymap))
  (general-def
    my/buffer-map
    "b" #'(ivy-switch-buffer :wk "switch-buffer")
    "d" #'(kill-this-buffer :wk "kill")
    "k" #'(kill-buffer-and-window :wk "kill-with-window")
    "n" #'(next-buffer :wk "next")
    "p" #'(previous-buffer :wk "previous")
    "s" #'(my/switch-to-scratch-buffer :wk "scratch-buffer"))

  ;; file
  (defvar my/file-map (make-sparse-keymap))
  (general-def
    my/file-map
    "f" #'(counsel-find-file :wk "find-file")
    "r" #'(counsel-recentf :wk "recentf")
    "l" #'(counsel-find-library :wk "find-library"))

  ;; help
  (defvar my/help-map (copy-keymap help-map))
  ;; (general-def
  ;;  my/help-map
  ;;  "a" #'(counsel-apropos :which-key "apropos")
  ;;  "b" #'(counsel-descbinds :which-key "bindings")
  ;;  "f" #'(counsel-describe-function :which-key "function")
  ;;  "F" #'(counsel-face :which-key "face")
  ;;  "v" #'(counsel-describe-variable :which-key "variable")
  ;;  )

  ;; quit
  (defvar my/quit-map (make-sparse-keymap))
  (general-def
    my/quit-map
    "r" #'(restart-emacs :wk "restart")
    "q" #'(kill-emacs :wk "quit"))

  ;; text
  (defvar my/text-map (make-sparse-keymap))
  (general-def
    my/text-map
    "t" #'google-translate-at-point
    "T" #'google-translate-at-point-reverse
    "q" #'google-translate-query-translate
    "Q" #'google-translate-query-translate-reverse)

  (my/leader-def
   '(normal visual)
   "SPC" #'(counsel-M-x :wk "M-x")
   "RET" #'(centaur-tabs-counsel-switch-group: :wk "switch tabs")
   ","   #'(counsel-switch-buffer :wk "switch buffer")
   "."   #'(ivy-resume :wk "resume ivy")
   "0"   #'(treemacs-select-window :wk "treemacs")
   "1"   #'winum-select-window-1
   "2"   #'winum-select-window-2
   "3"   #'winum-select-window-3
   "4"   #'winum-select-window-4
   "5"   #'winum-select-window-5
   "6"   #'winum-select-window-6
   "7"   #'winum-select-window-7
   "8"   #'winum-select-window-8
   "9"   #'winum-select-window-9

   "/"   #'(:keymap my/search-map :wk "search")
   "a"   #'(:keymap my/app-map :wk "app")
   "b"   #'(:keymap my/buffer-map :wk "buffer")
   "f"   #'(:keymap my/file-map :wk "file")
   "h"   #'(:keymap my/help-map :wk "help")
   "q"   #'(:keymap my/quit-map :wk "quit")
   "w"   #'(:keymap my/window-map :wk "window")
   "x"   #'(:keymap my/text-map :wk "text"))

  ;; grouping winum keybindings
  ;; https://emacs.stackexchange.com/questions/36658/how-to-group-key-bindings-in-which-key
  (push '(("\\(.*\\) 1" . "winum-select-window-1") . ("\\2 1..9" . "window 1..9"))
        which-key-replacement-alist)
  (push '((nil . "winum-select-window-[2-9]") . t) which-key-replacement-alist))

;; comint-mode map
(progn
  (general-def
    comint-mode-map
    "C-M-h" #'evil-window-left
    "C-M-j" #'evil-window-down
    "C-M-k" #'evil-window-up
    "C-M-l" #'evil-window-right
    "C-l"   #'comint-clear-buffer))
