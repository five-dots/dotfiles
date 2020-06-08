;;; packages.el --- my-ess layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Shun Asai <syun.asai@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst my-ess-packages
  '(
    company
    flycheck
    ess
    ess-R-data-view
    ess-smart-equals
    (ess-r-spreadsheet :location (recipe :fetcher github :repo "five-dots/ess-r-spreadsheet"))
    ))

(defun my-ess/post-init-company ()
  (dolist (mode '(ess-r-mode inferior-ess-r-mode))
    (spacemacs|add-company-backends
      :backends
      (company-R-library company-R-args company-R-objects company-files :with company-yasnippet)
      :modes mode)))

(defun my-ess/post-init-flycheck ()
  (spacemacs/enable-flycheck 'ess-r-mode))

(defun my-ess/init-ess ()
  (use-package ess-r-mode
    :init
    ;; "Fixes a bug when `comint-prompt-read-only' in non-nil.
    ;; See https://github.com/emacs-ess/ESS/issues/300"
    (defun my/ess-fix-read-only-inferior-ess-mode ()
      (setq-local comint-use-prompt-regexp nil)
      (setq-local inhibit-field-text-motion nil))

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

    :hook
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

    :config
    (setq ess-offset-continued '(straight . 2)) ; or '(cascade . 2)
    (setq ess-eldoc-show-on-symbol t)
    (setq ess-nuke-trailing-whitespace-p t)
    (setq ess-use-flymake nil) ; set nil to use flycheck
    (setq ess-style 'RStudio)
    (setq ess-history-file nil)
    (setq ess-indent-with-fancy-comments nil)
    (setq ess-eval-visibly t) ; performance impact

    ;; Disable unnecessary completion
    (setq ess-use-R-completion nil)
    (setq ess-use-auto-complete nil)
    (setq ess-use-ido nil)

    ;; Object popup by tooltip
    (setq ess-describe-at-point-method 'tooltip) ; nil or tooltip
    (setq x-gtk-use-system-tooltips nil)
    (setq tooltip-hide-delay 60)
    (setq ess-R-describe-object-at-point-commands
          '(("str(%s)")
            (".ess_htsummary(%s, hlength = 10, tlength = 10)")
            ("summary(%s, maxsum = 20)")))

    ;; %>% Pipe
    (evil-define-key 'insert ess-r-mode-map
      (kbd "C->") 'my/insert-R-pipe)
    (evil-define-key '(normal visual) ess-r-mode-map
      (kbd "C-H-;") 'ess-eval-region-or-line-visibly-and-step)

    ;; xref integration added with #96ef5a6
    (spacemacs|define-jump-handlers ess-r-mode 'xref-find-definitions)

    ;; Disable overlapped mappings
    (bind-keys :map ess-doc-map
               ("h"   . ess-display-help-on-object)
               ("d"   . nil)
               ("e"   . nil)
               ("m"   . nil)
               ("C-a" . nil)
               ("C-d" . nil)
               ("C-e" . nil)
               ("C-o" . nil)
               ("C-v" . nil)
               ("C-w" . nil)
               ("RET" . nil)
               ("TAB" . nil))
    (bind-keys :map ess-extra-map
               ("C-d" . nil)
               ("C-e" . nil)
               ("C-l" . nil)
               ("C-r" . nil)
               ("C-s" . nil)
               ("C-t" . nil)
               ("C-w" . nil)
               ("TAB" . nil)
               ("b" . ess-eval-buffer)
               ("f" . ess-eval-function)
               ("s" . ess-switch-process)
               ("S" . ess-set-style)
               ("p" . my/ess-load-projecttemplate-project))
    (bind-keys :map ess-r-package-dev-map
               ("C-a" . nil)
               ("C-b" . nil)
               ("C-c" . nil)
               ("c C-c" . nil)
               ("c C-w" . nil)
               ("C-d" . nil)
               ("C-e" . nil)
               ("C-l" . nil)
               ("C-s" . nil)
               ("C-t" . nil)
               ("C-u" . nil)
               ("f" . my/ess-r-devtools-test-file))
    (bind-keys :map ess-dev-map
               ("C-b" . nil)
               ("C-d" . nil)
               ("C-e" . nil)
               ("C-k" . nil)
               ("C-l" . nil)
               ("C-n" . nil)
               ("C-o" . nil)
               ("C-p" . nil)
               ("C-s" . nil)
               ("C-u" . nil)
               ("C-w" . nil))
    (bind-keys :map ess-debug-minor-mode-map
               ("H-C" . ess-debug-command-continue)
               ("H-N" . ess-debug-command-next)
               ("H-Q" . ess-debug-command-quit)
               ("H-S" . my/ess-debug-command-step-into)
               ("H-U" . ess-debug-command-up))

    ;; prefix label
    (dolist (mode '(ess-r-mode inferior-ess-r-mode))
      (spacemacs/declare-prefix-for-mode mode "md" "debug")
      (spacemacs/declare-prefix-for-mode mode "me" "eval")
      (spacemacs/declare-prefix-for-mode mode "mh" "help")
      (spacemacs/declare-prefix-for-mode mode "mg" "xref")
      (spacemacs/declare-prefix-for-mode mode "mp" "package-dev")
      (spacemacs/declare-prefix-for-mode mode "mpc" "check")
      (spacemacs/declare-prefix-for-mode mode "ms" "show")

      ;; local leader map
      (spacemacs/set-leader-keys-for-major-mode mode
        ","   #'ess-eval-region-or-function-or-paragraph
        "'"   #'R
        "."   #'ess-describe-object-at-point
        "TAB" #'ess-switch-to-inferior-or-script-buffer
        ";"   #'my/ess-print-at-point
        "["   #'my/ess-str-at-point
        "0"   #'ess-rdired
        ;; predefined keymap
        "e" #'ess-extra-map  ; eval
        "d" #'ess-dev-map ; debug
        "h" #'ess-doc-map ; help
        "p" #'ess-r-package-dev-map ; package-dev
        ;; show
        "sp" #'my/ess-print-at-point
        "sr" #'my/ess-str-at-point
        ))

    ;; keymap
    (evil-define-key '(normal visual) ess-r-mode-map
      ";" #'ess-eval-region-or-line-visibly-and-step)

    ;; inferior-ess-r-mode
    (evil-set-initial-state 'inferior-ess-r-mode 'normal)

    ;; ess-r-help-mode
    (evil-set-initial-state 'ess-r-help-mode 'normal)
    (evil-define-key 'normal ess-r-help-mode-map
      "J" 'ess-skip-to-next-section
      "K" 'ess-skip-to-previous-section
      "q" 'kill-this-buffer
      "W" 'ess-display-help-in-browser)

    ;;; evilify keymaps
    ;; TODO ess-watch-mode-map
    ;; ctbl:table-mode (for ess-R-dv-ctable)
    (evil-define-key 'normal ctbl:table-mode-map
      "q" 'kill-this-buffer)

    ;; TODO hydra map for ess-tracebug
    (defhydra hydra-ess-tracebug (:color pink :hint nil)
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
    (spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
      "d." 'hydra-ess-tracebug/body)))

(defun my-ess/init-ess-R-data-view ()
  (use-package ess-R-data-view
    :after
    (:any ess-r-mode inferior-ess-r-mode ess-r-transcript)

    :commands
    (ess-R-dv-ctable ess-R-dv-pprint)

    :init
    (dolist (mode '(ess-r-mode inferior-ess-r-mode))
      (spacemacs/set-leader-keys-for-major-mode mode
        "st" #'ess-R-dv-ctable))
    ))

(defun my-ess/init-ess-r-spreadsheet ()
  (use-package ess-r-spreadsheet
    :after
    (:any ess-r-mode inferior-ess-r-mode ess-r-transcript)

    :commands
    (ess-r-spreadsheet)

    :init
    (dolist (mode '(ess-r-mode inferior-ess-r-mode))
      (spacemacs/set-leader-keys-for-major-mode mode
        "ss" #'ess-r-spreadsheet))
    ))

(defun my-ess/init-ess-smart-equals ()
  (use-package ess-smart-equals
    :hook
    ((ess-r-mode . ess-smart-equals-mode)
     (inferior-ess-r-mode . ess-smart-equals-mode)
     (ess-r-transcript-mode . ess-smart-equals-mode)
     (ess-roxy-mode . ess-smart-equals-mode))

    :config
    (setq ess-smart-equals-extra-ops '(brace)) ; brace, paren, parcent

    (setf
     (cdr (assq '% (assq 't ess-smart-equals-contexts)))
     '("%>%" "%in%" "%*%" "%%" "%/%" "%<>%" "%o%" "%x%" "%|%" "%||%"))))
