;;; packages.el --- my-ess layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: shun <shun@x1>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst my-ess-packages
  '(
    ess
    ess-R-data-view
    ess-smart-equals
    (ess-r-spreadsheet
     :location
     (recipe :fetcher github :repo "five-dots/ess-r-spreadsheet"))
    ;; TODO snippets for R
    ))

(defun my-ess/init-ess ()
  (use-package ess-r-mode
    :init
    ;; "Fixes a bug when `comint-prompt-read-only' in non-nil.
    ;; See https://github.com/emacs-ess/ESS/issues/300"
    (defun my/ess-fix-read-only-inferior-ess-mode ()
      (setq-local comint-use-prompt-regexp nil)
      (setq-local inhibit-field-text-motion nil))
    (add-hook 'inferior-ess-r-mode-hook 'my/ess-fix-read-only-inferior-ess-mode)

    ;; company backends
    (when (configuration-layer/package-used-p 'company)
      (add-hook 'ess-r-mode-hook 'my/set-company-backend-for-r))

    :hook
    (ess-r-mode . company-mode)
    (inferior-ess-r-mode . company-mode)
    :commands run-ess-r
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
    (setq ess-nuke-trailing-whitespace-p t)
    (setq ess-use-flymake nil) ; set nil to use flycheck
    (setq ess-style 'DEFAULT)
    (setq ess-eldoc-show-on-symbol t)
    (setq ess-history-file nil)
    (setq ess-use-R-completion nil)
    (setq ess-use-auto-complete nil)
    (setq ess-use-ido nil)

    ;; Object popup by tooltip
    ;; TODO use fixed width font on gtk tooltip
    (setq ess-describe-at-point-method 'tooltip)
    (setq x-gtk-use-system-tooltips t)
    (setq tooltip-hide-delay 60)
    (setq ess-R-describe-object-at-point-commands
          '(("str(%s)")
            (".ess_htsummary(%s, hlength = 14, tlength = 14)")
            ("summary(%s, maxsum = 20)")))

    ;; %>% Pipe
    (bind-keys :map evil-insert-state-map
               ("C->". my/insert-R-pipe))

    ;; xref integration added with #96ef5a6
    (spacemacs|define-jump-handlers ess-r-mode 'xref-find-definitions)

    ;; prefix label
    (dolist (mode '(ess-r-mode inferior-ess-r-mode))
      (spacemacs/declare-prefix-for-mode mode "md" "debug")
      (spacemacs/declare-prefix-for-mode mode "me" "eval")
      (spacemacs/declare-prefix-for-mode mode "mh" "help")
      (spacemacs/declare-prefix-for-mode mode "mg" "xref")
      (spacemacs/declare-prefix-for-mode mode "mp" "package-dev")
      (spacemacs/declare-prefix-for-mode mode "mpc" "check")
      (spacemacs/declare-prefix-for-mode mode "mv" "view"))

    ;; keymap
    (spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
      ","   'ess-eval-region-or-function-or-paragraph
      "'"   'run-ess-r
      "."   'ess-describe-object-at-point
      "TAB" 'ess-switch-to-inferior-or-script-buffer

      ;; predefined keymap
      "e" 'ess-extra-map
      ;; TODO hydra-map for ess-dev-map (debug map)
      "d" 'ess-dev-map
      "h" 'ess-doc-map
      "p" 'ess-r-package-dev-map
      ;; eval
      "eb" 'ess-eval-buffer
      "ef" 'ess-eval-function
      "eS" 'ess-switch-process
      ;; view
      ;; "vs" 'ess-spreadsheet
      )

    ;; inferior-ess-r-mode
    (evil-set-initial-state 'inferior-ess-r-mode 'normal)
    (spacemacs/set-leader-keys-for-major-mode 'inferior-ess-r-mode
      "," 'ess-smart-comma
      "." 'ess-describe-object-at-point
      "TAB" 'ess-switch-to-inferior-or-script-buffer

      ;; predefined keymap
      "e" 'ess-extra-map
      "d" 'ess-dev-map
      "h" 'ess-doc-map
      "p" 'ess-r-package-dev-map
      ;; view
      ;; "vs" 'ess-spreadsheet
      )

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
               ("TAB" . nil))
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
               ("C-u" . nil))
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
    (bind-keys :map inferior-ess-r-mode-map
               ("C-l" . spacemacs/comint-clear-buffer)
               ("C-M-l" . evil-window-right))

    ;; ess-r-help-mode
    (evil-set-initial-state 'ess-r-help-mode 'normal)
    (evil-define-key 'normal ess-r-help-mode-map
      "J" 'ess-skip-to-next-section
      "K" 'ess-skip-to-previous-section
      "q" 'kill-this-buffer
      "W" 'ess-display-help-in-browser)

    ;; TODO window position management
    ;; - ess-r-help-mode
    ;; - ess-watch-mode
    ;; (add-to-list
    ;;  'display-buffer-alist
    ;;  '("^\\*help[R]" . ((display-buffer-same-window) (inhibit-same-window . nil))))
    ;; ctbl:table-mode (for ess-R-dv-ctable)

    ;; TODO ess-watch-mode keymap
    ;; - evilify keymaps
    (evil-define-key 'normal ctbl:table-mode-map
      "q" 'kill-this-buffer)

    ;; TODO Configure by each package
    ;; (use-package ess-tracebug)
    ;; (use-package ess-help)

    ;; TODO hydra map for ess-tracebug
    (defhydra hydra-ess-tracebug (:color pink :hint nil)
      "
^Stepping^            ^Breakpoints^        ^Debugging^
^^--------------------^^-------------------^^------------------------
_sc_: Continue        _bt_: Toggle         _d`_: Traceback
_sC_: Continue multi  _ba_: Add            _d~_: Callstack
_sn_: Next            _bd_: Delete         _de_: Toggle error action
_sN_: Next multi      _bD_: Delete all     _dd_: Flag for debugging
_su_: Up frame        _bc_: Set condition  _du_: Unflag for debugging
_sq_: Quit            _bl_: Set logger     _dw_: Watch window
"
      ;; Stepping
      ("sc" ess-debug-command-continue)
      ("sC" ess-debug-command-continue-multi)
      ("sn" ess-debug-command-next)
      ("sN" ess-debug-command-next-multi)
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
    :after (:any ess-r-mode inferior-ess-r-mode ess-r-transcript)
    :commands (ess-R-dv-ctable ess-R-dv-pprint)
    :init
    (dolist (mode '(ess-r-mode inferior-ess-r-mode))
      (spacemacs/set-leader-keys-for-major-mode mode
        ;; view
        ;; "vp" 'ess-R-dv-pprint
        "vt" 'ess-R-dv-ctable))))

(defun my-ess/init-ess-r-spreadsheet ()
  (use-package ess-r-spreadsheet
    :after (:any ess-r-mode inferior-ess-r-mode ess-r-transcript)
    :commands (ess-r-spreadsheet)
    :init
    (dolist (mode '(ess-r-mode inferior-ess-r-mode))
      (spacemacs/set-leader-keys-for-major-mode mode
        ;; view
        "vs" 'ess-r-spreadsheet))))

(defun my-ess/init-ess-smart-equals ()
  (use-package ess-smart-equals
    ;; :init
    ;; (setq ess-smart-equals-extra-ops '(percent))
    :hook
    ((ess-r-mode . ess-smart-equals-mode)
     (inferior-ess-r-mode . ess-smart-equals-mode)
     (ess-r-transcript-mode . ess-smart-equals-mode)
     (ess-roxy-mode . ess-smart-equals-mode))))


