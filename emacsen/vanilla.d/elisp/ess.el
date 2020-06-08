;;; ess

(use-package ess-r-mode
  :straight nil

  :load-path
  "~/Dropbox/repos/github/five-dots/dotfiles/emacsen/vanilla-emacs.d/straight/build/ess"

  :hook
  ;; TODO company-backends
  (ess-r-mode . my/set-company-backend-for-r)
  (ess-r-mode . company-mode)
  (inferior-ess-r-mode . company-mode)
  (inferior-ess-r-mode . my/ess-fix-read-only-inferior-ess-mode)

  :interpreter
  ("Rscript" . ess-r-mode)

  :commands
  (run-ess-r R)

  :mode
  (("/R/.*\\.q\\'"      . ess-r-mode)
   ("\\.[rR]\\'"        . ess-r-mode)
   ("\\.[rR]profile\\'" . ess-r-mode)
   ("NAMESPACE\\'"      . ess-r-mode)
   ("CITATION\\'"       . ess-r-mode)
   ("\\.[Rr]out"        . R-transcript-mode)
   ("\\.Rd\\'"          . Rd-mode))

  :init
  ;; "Fixes a bug when `comint-prompt-read-only' in non-nil.
  ;; See https://github.com/emacs-ess/ESS/issues/300"
  (defun my/ess-fix-read-only-inferior-ess-mode ()
    (setq-local comint-use-prompt-regexp nil)
    (setq-local inhibit-field-text-motion nil))

  ;; Control window display
  ;; (dolist
  ;;     (l '(
  ;;          ("^\\*ess-describe"
  ;;           (display-buffer-reuse-window display-buffer-same-window)
  ;;           (reusable-frames . nil))
  ;;          ("^\\*help\\[R\\]("
  ;;           (display-buffer-reuse-window display-buffer-in-side-window)
  ;;           (side . right)
  ;;           (slot . -1)
  ;;           (window-width . 0.5)
  ;;           (reusable-frames . nil))
  ;;          ("^\\*R"
  ;;           (display-buffer-reuse-window display-buffer-in-side-window)
  ;;           (side . left)
  ;;           ;; TODO split window by equal width
  ;;           (window-width . 0.5)
  ;;           (reusable-frames . t))
  ;;          ("^\\*R dired"
  ;;           (display-buffer-reuse-window display-buffer-in-side-window)
  ;;           (side . right)
  ;;           (slot . -1)
  ;;           (window-width . 0.2)
  ;;           (reusable-frames . nil))
  ;;          ))
  ;;   (add-to-list 'display-buffer-alist l))

  ;;; Use dedicated frame for help
  ;; (setq ess-help-frame-alist
  ;;       '(
  ;;         (width . 80)
  ;;         (height . 50)
  ;;         (minibuffer . nil)
  ;;         (unsplittable . t)
  ;;         ))
  ;; (setq ess-help-own-frame 'one)

  :config
  (setq ess-offset-continued '(straight . 2)) ; or '(cascade . 2)
  (setq ess-nuke-trailing-whitespace-p t)
  (setq ess-use-flymake nil) ; set nil to use flycheck
  (setq ess-style 'RStudio)
  (setq ess-eldoc-show-on-symbol t)
  (setq ess-history-file nil)
  (setq ess-indent-with-fancy-comments nil)

  ;; TODO performance issue
  (setq ess-eval-visibly nil)
  (setq ess-eval-visibly-p nil)

  ;; Disable unnecessary completion
  (setq ess-use-R-completion nil)
  (setq ess-use-auto-complete nil)
  (setq ess-use-ido nil)

  ;; Object popup by tooltip
  (setq ess-describe-at-point-method 'tooltip)
  (setq x-gtk-use-system-tooltips nil)
  (setq tooltip-hide-delay 60)
  (setq ess-R-describe-object-at-point-commands
        '(("str(%s)")
          (".ess_htsummary(%s, hlength = 10, tlength = 10)")
          ("summary(%s, maxsum = 20)")))

  ;; TODO xref integration added with #96ef5a6
  ;; (spacemacs|define-jump-handlers ess-r-mode 'xref-find-definitions)

  ;; ess-dev-map (debug)
  (defvar my/ess-dev-map (copy-keymap ess-dev-map))
  (general-unbind
   'my/ess-dev-map
   "C-b" "C-d" "C-e" "C-k" "C-l" "C-n" "C-o" "C-p" "C-s" "C-u" "C-w")

  ;; ess-doc-map (help)
  (defvar my/ess-doc-map (copy-keymap ess-doc-map))
  (general-unbind
   'my/ess-doc-map
   "d" "e" "m" "C-a" "C-d" "C-e" "C-o" "C-v" "C-w" "RET" "TAB")
  (general-def
   'my/ess-doc-map
   "h" #'ess-display-help-on-object)

  ;; ess-extra-map (eval)
  (defvar my/ess-extra-map (copy-keymap ess-extra-map))
  (general-unbind
   'my/ess-extra-map
   "C-d" "C-e" "C-l" "C-r" "C-s" "C-t" "C-w" "TAB")
  (general-def
   'my/ess-extra-map
   "b"  #'ess-eval-buffer
   "f"  #'ess-eval-function
   "s"  #'ess-switch-process
   "S"  #'ess-set-style
   "p"  #'my/ess-load-projecttemplate-project)

  ;; ess-r-package-dev-map (package-dev)
  (defvar my/ess-r-package-dev-map (copy-keymap ess-r-package-dev-map))
  (general-unbind
   'my/ess-r-package-dev-map
   "C-a" "C-b" "C-c" "c C-c" "c C-w" "C-d" "C-e" "C-l" "C-s" "C-t" "C-u")

  ;; show
  (defvar my/ess-show-map (make-sparse-keymap))

  ;; keymap
  (general-def
   '(normal visual) ess-r-mode-map
   ";" #'ess-eval-region-or-line-visibly-and-step)
  (general-def
   '(insert) ess-r-mode-map
   "C->" #'my/insert-R-pipe)

  ;; local-leader map for ess-r-mode and inferior-ess-r-mode
  ;; TODO check other ess-*-map
  (my/local-leader-def
   '(normal visual) (ess-r-mode-map inferior-ess-r-mode-map)
   "."   #'(ess-describe-object-at-point :wk "describe object")
   "TAB" #'(ess-switch-to-inferior-or-script-buffer :wk "switch to REPL/script")
   "e"   #'(:keymap my/ess-extra-map :wk "eval")
   "d"   #'(:keymap my/ess-dev-map :wk "debug")
   "h"   #'(:keymap my/ess-doc-map :wk "help")
   "p"   #'(:keymap my/ess-r-package-dev-map :wk "package-dev")
   "s"   #'(:keymap my/ess-show-map :wk "show"))

  (my/local-leader-def
   '(normal visual) (ess-r-mode-map)
   ","   #'(ess-eval-region-or-function-or-paragraph :wk "eval r-f-p")
   "'"   #'(R :wk "REPL"))

  ;; local-leader map for inferior-ess-r-mode
  (evil-set-initial-state 'inferior-ess-r-mode 'normal)
  (my/local-leader-def
   '(normal visual) (inferior-ess-r-mode-map)
   ","   #'(ess-smart-comma :wk "smart comma"))

  ;; ess-r-help-mode
  (evil-set-initial-state 'ess-r-help-mode 'normal)
  (evil-define-key 'normal ess-r-help-mode-map
    "J" #'ess-skip-to-next-section
    "K" #'ess-skip-to-previous-section
    "q" #'kill-this-buffer
    "W" #'ess-display-help-in-browser)

  ;; evilify keymaps
  ;; TODO ess-watch-mode-map
  ;; ctbl:table-mode (for ess-R-dv-ctable)
  (evil-define-key 'normal ctbl:table-mode-map
    "q" 'kill-this-buffer)

  ;; custom functions for ess-tracebug
  (defun my/ess-debug-command-step-into ()
    "Step into the next code. Equivalent of `s' at the R prompt."
    (interactive)
    (ess-force-buffer-current)
    (cond ((ess--dbg-is-recover-p)
           (ess-send-string (ess-get-process) "0"))
          ((ess--dbg-is-active-p)
           (ess-send-string (ess-get-process) "s"))
          (t
           (error "Debugger is not active"))))

  (general-def
   ess-debug-minor-mode-map
   "M-S" #'my/ess-debug-command-step-into)

  (defhydra my/hydra-ess-tracebug (:color pink :hint nil)
      "
^Stepping^            ^Breakpoints^        ^Debugging^
^^--------------------^^-------------------^^------------------------
_sc_: Continue        _bt_: Toggle         _d`_: Traceback
_sC_: Continue multi  _ba_: Add            _d~_: Callstack
_sn_: Next            _bd_: Delete         _de_: Toggle error action
_sN_: Next multi      _bD_: Delete all     _dd_: Flag for debugging
_ss_: Step into       _bc_: Set condition  _du_: Unflag for debugging
_su_: Up frame        _bl_: Set logger     _dw_: Watch window
_sq_: Quit
"
      ;; Stepping
      ("sc" ess-debug-command-continue)
      ("sC" ess-debug-command-continue-multi)
      ("sn" ess-debug-command-next)
      ("sN" ess-debug-command-next-multi)
      ("ss" my/ess-debug-command-step-into)
      ("su" ess-debug-command-up)
      ("sq" ess-debug-command-quit)
      ;; Breakpoints
      ("bt" ess-bp-toggle-state)
      ("ba" ess-bp-set)
      ("bd" ess-bp-kill)
      ("bD" ess-bp-kill-all)
      ("bc" ess-bp-set-conditional)
      ("bl" ess-bp-set-logger)
      ;; Debugging
      ("d`" ess-show-traceback)
      ("d~" ess-show-call-stack)
      ("de" ess-debug-toggle-error-action)
      ("dd" ess-debug-flag-for-debugging)
      ("du" ess-debug-unflag-for-debugging)
      ("dw" ess-watch)
      ("q" nil "Close" :color blue))

  (general-def
   'my/ess-dev-map
   "." #'my/hydra-ess-tracebug/body)
  )

(use-package ess-R-data-view
  :after
  (:any ess-r-mode inferior-ess-r-mode ess-r-transcript)

  :commands
  (ess-R-dv-ctable ess-R-dv-pprint)

  :general
  (my/ess-show-map
   "t" #'ess-R-dv-ctable))

(use-package ess-smart-equals
  :hook
  ((ess-r-mode inferior-ess-r-mode ess-r-transcript-mode ess-roxy-mode) . ess-smart-equals-mode)

  :init
  (setq ess-smart-equals-extra-ops '(brace percent)))

(use-package ess-r-spreadsheet
  :straight nil

  :load-path "~/Dropbox/repos/github/five-dots/ess-r-spreadsheet"

  :after
  (:any ess-r-mode inferior-ess-r-mode ess-r-transcript)

  :commands
  (ess-r-spreadsheet)

  ;; :config
  ;; (setq ess-r-spreadsheet-programs "libreoffice")

  :general
  (my/ess-show-map
   "s" #'ess-r-spreadsheet))

(use-package r-autoyas :disabled t
  :config
  (setq r-autoyas-expand-package-functions-only nil))
