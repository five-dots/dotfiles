;;; packages.el --- oreore layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: shun <shun@x1>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst oreore-packages
  '(
    crontab-mode
    ;; dotnet
    ;; exec-path-from-shell
    ;; evil-fringe-mark
    google-this
    helpful
    lispxmp
    ;; lispy
    magit-todos
    quickrun
    ;; recentf-ext
    ;; (hatena-blog-mode
    ;;  :location
    ;;  (recipe :fetcher github :repo "fnwiya/hatena-blog-mode"))
    visual-regexp
    visual-regexp-steroids
    ;; undohist
    ;; TODO flx for fuzzy matching

    ;; org-mode
    ;; (ox-hatena
    ;;  :location
    ;;  (recipe :fetcher github :repo "yynozk/ox-hatena"))
    (ox-qmd
     :location
     (recipe :fetcher github :repo "0x60df/ox-qmd"))

    ;; ui
    centaur-tabs
    ;; beacon
    hide-mode-line
    highlight-indent-guides
    ivy-posframe

    ;; ess
    ess
    ess-R-data-view
    ess-smart-equals
    (ess-r-spreadsheet
     :location
     (recipe :fetcher github :repo "five-dots/ess-r-spreadsheet"))
    ;; TODO snippets for R

    ;; japanese
    ;; ddskk
    pangu-spacing
    mozc
    ))

;; (defun oreore/init-undohist ()
;;   (use-package undohist
;;     :config
;;     (setq undohist-directory (expand-file-name "undohist" spacemacs-cache-directory))))

(defun oreore/init-crontab-mode ()
  (use-package crontab-mode
    :mode (("\\.cron\\(tab\\)?\\'" . crontab-mode)
           ("cron\\(tab\\)?\\." . crontab-mode))))

;; (defun oreore/init-dotnet ()
;;   (use-package dotnet
;;     :hook
;;     (csharp-mode . dotnet-mode)
;;     :config
;;     (spacemacs/declare-prefix-for-mode 'csharp-mode "mc" "dotnet-cli")
;;     (spacemacs/declare-prefix-for-mode 'csharp-mode "mcg" "goto")
;;     (spacemacs/declare-prefix-for-mode 'csharp-mode "mcs" "sln")
;;     (spacemacs/set-leader-keys-for-major-mode 'csharp-mode
;;       "c ." 'dotnet-run
;;       "c b" 'dotnet-build
;;       "c c" 'dotnet-clean
;;       "c n" 'dotnet-new
;;       "c p" 'dotnet-add-package
;;       "c r" 'dotnet-add-reference
;;       "c t" 'dotnet-test
;;       ;; goto
;;       "c g p" 'dotnet-goto-csproj
;;       "c g s" 'dotnet-goto-sln
;;       ;; sln
;;       "c s l" 'dotnet-sln-list
;;       "c s n" 'dotnet-sln-new
;;       "c s r" 'dotnet-sln-remove)))

;; (defun oreore/init-evil-fringe-mark ()
;;   (use-package exec-path-from-shell
;;     :init
;;     (global-evil-fringe-mark-mode)
;;     (setq-default left-fringe-width 16)))

;; (defun oreore/init-exec-path-from-shell ()
;;   (use-package exec-path-from-shell
;;     :config
;;     (exec-path-from-shell-initialize)))

(defun oreore/init-google-this ()
  (use-package google-this
    :commands google-this))

(defun oreore/init-helpful ()
  (use-package helpful
    :defer t
    ;; TODO evilify helpful-mode
    ;; :init
    ;; (setq counsel-describe-function-function #'helpful-callable)
    ;; (setq counsel-describe-variable-function #'helpful-variable)
    ))

;; (defun oreore/init-lispy ()
;;   (use-package lispy
;;     ;; :hook
;;     ;; (emacs-lisp-mode . lispy-mode)
;;     ;; (lisp-interaction-mode . lispy-mode)
;;     ))

(defun oreore/init-lispxmp ()
  (use-package lispxmp
    :config
    (spacemacs/set-leader-keys-for-major-mode 'emacs-lisp-mode
      "e x" 'lispxmp)
    (spacemacs/set-leader-keys-for-major-mode 'lisp-interaction-mode
      "e x" 'lispxmp)))

;; (defun oreore/init-recentf-ext ()
;;   (use-package recentf-ext))

(defun oreore/init-magit-todos ()
  (use-package magit-todos))

(defun oreore/init-quickrun ()
  (use-package quickrun))

;; (defun oreore/init-hatena-blog-mode ()
;;   (use-package hatena-blog-mode
;;     :config
;;     (setq hatena-id "five-dots")
;;     (setq hatena-blog-api-key my/hatena-blog-api-key)
;;     (setq hatena-blog-id "five-dots.hatenablog.com")
;;     (setq hatena-blog-editing-mode "md")
;;     (setq hatena-blog-backup-dir nil)))

(defun oreore/init-visual-regexp ()
  (use-package visual-regexp))

(defun oreore/init-visual-regexp-steroids ()
  (use-package visual-regexp-steroids))


;;; org-mode

;; (defun oreore/init-ox-hatena ()
;;   (use-package ox-hatena))

(defun oreore/init-ox-qmd ()
  (use-package ox-qmd
    :config
    (add-to-list 'ox-qmd-language-keyword-alist
                 '("R" . "r"))))


;;; ui
(defun oreore/init-centaur-tabs ()
  (use-package centaur-tabs
    :hook
    (after-init . centaur-tabs-mode)
    ;; disabled modes
    (treemacs-mode . centaur-tabs-local-mode)

    :config
    (setq centaur-tabs-style "bar")
    (setq centaur-tabs-set-icons t)
    (setq centaur-tabs-gray-out-icons 'buffer)
    (setq centaur-tabs-set-bar 'left)
    (setq centaur-tabs-cycle-scope 'tabs)

    ;; Prevent the access to specified buffers
    (defun centaur-tabs-hide-tab (x)
      (let ((name (format "%s" x)))
        (or
         ;; * で始まるバッファ
         (and (string-prefix-p "*" name)
              ;; (not) で除外するバッファを指定
              (not (string-prefix-p "*R" name))
              (not (string-prefix-p "*Python" name))
              ;; (not (string-prefix-p "*ansi-term-1" name)) ;
              (not (string-prefix-p "*eshell" name)))
         ;; magit
         (string-prefix-p "COMMIT_EDITMSG" name)
         (and (string-prefix-p "magit" name)
              (not (file-name-extension name))))))

    ;; buffer group function
    (defun centaur-tabs-buffer-groups ()
      (list
       (cond
        ((memq major-mode '(inferior-ess-r-mode
                            inferior-python-mode
                            eshell-mode
                            term-mode
                            ))
         "repl")
        ((derived-mode-p 'prog-mode)
         "coding")
        ((memq major-mode '(markdown-mode
                            text-mode
                            org-mode
                            org-src-mode
                            org-agenda-mode))
         "editing")
        ;; ((string-prefix-p "*" (buffer-name))
        ;;  "emacs")
        (t "other"))))

    ;; keymaps
    (spacemacs/set-leader-keys
      "RET" 'centaur-tabs-counsel-switch-group)
    (evil-define-key '(normal) 'global
      (kbd "C-M-,") 'centaur-tabs-backward
      (kbd "C-M-.") 'centaur-tabs-forward)
    (centaur-tabs-headline-match)))

;; (defun oreore/init-beacon ()
;;   (use-package beacon
;;     :defer t
;;     :hook (after-init . beacon-mode)
;;     :config
;;     (setq beacon-blink-when-window-scrolls nil)))

(defun oreore/init-hide-mode-line ()
  (use-package hide-mode-line
    :defer t
    :hook
    (treemacs-mode . hide-mode-line-mode)
    (ess-r-help-mode . hide-mode-line-mode)
    ))

(defun oreore/init-highlight-indent-guides ()
  (use-package highlight-indent-guides
    :hook
    ;; (emacs-lisp-mode . highlight-indent-guides-mode)
    ;; (ess-r-mode . highlight-indent-guides-mode)
    (csharp-mode . highlight-indent-guides-mode)
    :config
    ;; (setq highlight-indent-guides-responsive t)
    (setq highlight-indent-guides-method 'character)))

(defun oreore/init-ivy-posframe ()
  (use-package ivy-posframe
    :init
    (ivy-posframe-mode 1)
    :config
    (setq ivy-posframe-border-width 1)
    (setq ivy-posframe-min-width 110)
    (setq ivy-posframe-width 110)
    (setq ivy-posframe-min-height 15)
    (setq ivy-posframe-height 15)
    (setq ivy-posframe-parameters
          '((left-fringe . 5)
            (right-fringe . 5)))
    (setq ivy-posframe-display-functions-alist
          '((swiper . ivy-display-function-fallback)
            (swiper-all . ivy-display-function-fallback)
            (counsel-rg . ivy-display-function-fallback)
            (counsel-yank-pop . ivy-display-function-fallback)
            (t . ivy-posframe-display-at-frame-center)))
    :custom-face
    (ivy-posframe ((t (:background "#282a36"))))
    (ivy-posframe-border ((t (:background "#6272a4"))))
    (ivy-posframe-cursor ((t (:background "#61bfff"))))))


;;; ess
(defun oreore/init-ess ()
  (use-package ess-r-mode
    :init
    ;; "Fixes a bug when `comint-prompt-read-only' in non-nil.
    ;; See https://github.com/emacs-ess/ESS/issues/300"
    (defun my/ess-fix-read-only-inferior-ess-mode ()
      (setq-local comint-use-prompt-regexp nil)
      (setq-local inhibit-field-text-motion nil))

    ;; Control window display
    (dolist
        (l '(
             ("^\\*ess-describe"
              (display-buffer-reuse-window display-buffer-same-window)
              (reusable-frames . nil))
             ("^\\*help\\[R\\]("
              (display-buffer-reuse-window display-buffer-in-side-window)
              (side . right)
              (slot . -1)
              (window-width . 0.5)
              (reusable-frames . nil))
             ("^\\*R"
              (display-buffer-reuse-window display-buffer-in-side-window)
              (side . left)
              (reusable-frames . nil))
             ("^\\*R dired"
              (display-buffer-reuse-window display-buffer-in-side-window)
              (side . right)
              (slot . -1)
              (window-width . 0.2)
              (reusable-frames . nil))
             ))
      (add-to-list 'display-buffer-alist l))

    ;;; Use dedicated frame for help
    ;; (setq ess-help-frame-alist
    ;;       '(
    ;;         (width . 80)
    ;;         (height . 50)
    ;;         (minibuffer . nil)
    ;;         (unsplittable . t)
    ;;         ))
    ;; (setq ess-help-own-frame 'one)

    :hook
    (ess-r-mode . my/set-company-backend-for-r)
    (ess-r-mode . company-mode)
    (inferior-ess-r-mode . company-mode)
    (inferior-ess-r-mode . my/ess-fix-read-only-inferior-ess-mode)

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
    (setq ess-style 'RStudio)
    (setq ess-eldoc-show-on-symbol t)
    (setq ess-history-file nil)
    (setq ess-indent-with-fancy-comments nil)

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

    ;; %>% Pipe
    (evil-define-key 'insert 'global
      (kbd "C->") 'my/insert-R-pipe)

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
      (spacemacs/declare-prefix-for-mode mode "ms" "show"))

    ;; keymap
    (evil-define-key '(normal visual) ess-r-mode-map
      ";" 'ess-eval-region-or-line-visibly-and-step)
    (spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
      ","   'ess-eval-region-or-function-or-paragraph
      "'"   'R
      "."   'ess-describe-object-at-point
      "TAB" 'ess-switch-to-inferior-or-script-buffer

      ;; predefined keymap
      "e" 'ess-extra-map ; eval
      ;; TODO hydra-map for ess-dev-map (debug map)
      "d" 'ess-dev-map ; debug
      "h" 'ess-doc-map ; help
      "p" 'ess-r-package-dev-map ; package-dev
      ;; eval
      "eb" 'ess-eval-buffer
      "ef" 'ess-eval-function
      "es" 'ess-switch-process
      "eS" 'ess-set-style
      "ep" 'my/ess-load-projecttemplate-project)

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
      "p" 'ess-r-package-dev-map)

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

    ;;; custom functions for ess-tracebug
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

    (bind-keys :map ess-debug-minor-mode-map
               ("M-S" . my/ess-debug-command-step-into))

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

(defun oreore/init-ess-R-data-view ()
  (use-package ess-R-data-view
    :after (:any ess-r-mode inferior-ess-r-mode ess-r-transcript)
    :commands (ess-R-dv-ctable ess-R-dv-pprint)
    :init
    (dolist (mode '(ess-r-mode inferior-ess-r-mode))
      (spacemacs/set-leader-keys-for-major-mode mode
        ;; "sp" 'ess-R-dv-pprint
        "st" 'ess-R-dv-ctable))))

(defun oreore/init-ess-r-spreadsheet ()
  (use-package ess-r-spreadsheet
    :after (:any ess-r-mode inferior-ess-r-mode ess-r-transcript)
    :commands (ess-r-spreadsheet)
    :init
    (dolist (mode '(ess-r-mode inferior-ess-r-mode))
      (spacemacs/set-leader-keys-for-major-mode mode
        "ss" 'ess-r-spreadsheet))))

(defun oreore/init-ess-smart-equals ()
  (use-package ess-smart-equals
    ;; :init
    ;; (setq ess-smart-equals-extra-ops '(percent))
    :hook
    ((ess-r-mode . ess-smart-equals-mode)
     (inferior-ess-r-mode . ess-smart-equals-mode)
     (ess-r-transcript-mode . ess-smart-equals-mode)
     (ess-roxy-mode . ess-smart-equals-mode))))


;;; japanese

;; (defun oreore/init-ddskk ()
;;   (use-package ddskk
;;     :disabled t
;;     :defer t
;;     :commands skk-mode
;;     :hook
;;     ;; Always start using latin mode
;;     (evil-insert-state-entry . skk-mode)
;;     ;; Disable skk mode when entering normal state
;;     (evil-normal-state-entry . (lambda () (skk-mode -1)))
;;     (skk-mode . skk-latin-mode-on)

;;     :init
;;     (setq default-input-method "japanese-skk")
;;     ;; No new line by kakutei
;;     (setq skk-egg-like-newline t)
;;     ;; Henkan candidates
;;     (setq skk-show-inline t)
;;     ;; Cursor color
;;     (setq skk-cursor-hiragana-color "yellow")
;;     (setq skk-cursor-katakana-color "blue violet")
;;     ;; Record file
;;     (setq skk-record-file "~/Dropbox/skk/record")

;;     ;;; Jisyo
;;     (setq skk-save-jisyo-instantly t)
;;     ;; Personal jisyo
;;     (setq skk-jisyo "~/Dropbox/skk/jisyo/skk-jisyo")
;;     (setq skk-backup-jisyo "~/Dropbox/skk/jisyo/skk-jisyo.bak")
;;     ;; large jisyo
;;     (setq skk-large-jisyo "~/Dropbox/skk/jisyo/SKK-JISYO.L")
;;     ;; Extra jisyo
;;     ;; (setq skk-extra-jisyo-file-list
;;     ;;       (list "~/Dropbox/skk/jisyo/SKK-JISYO.JIS2"
;;     ;;             '("~/Dropbox/skk/jisyo/SKK-JISYO.JIS3_4" . euc-jisx0213)
;;     ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.assoc"
;;     ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.notes"
;;     ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.geo"
;;     ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.hukugougo"
;;     ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.jinmei"
;;     ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.law"
;;     ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.lisp"
;;     ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.okinawa"
;;     ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.propernoun"
;;     ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.pubdic+"
;;     ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.station"
;;     ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.zipcode"
;;     ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.office.zipcode"))
;;     ;; saving skk jisyo ... done というメッセージが表示されるのを省略
;;     ;; http://slackwareirregulars.blogspot.com/2018/03/skk.html
;;     ;; FIXME saving skk jisyo ... が引き続き表示されてしまう
;;     (defun skk-save-jisyo (&optional quiet)
;;       (interactive "P")
;;       (funcall skk-save-jisyo-function 'quiet))
;;     ;; :config
;;     ;; TODO 現在の skk mode に応じて [muhenkan] key で
;;     ;; latin <-> hiragana を切り替える関数
;;     ;; (bind-keys :map skk-latin-mode-map
;;     ;;            ([muhenkan] . skk-kakutei))
;;     ))

(defun oreore/init-pangu-spacing ()
  (use-package pangu-spacing
    :init
    (setq pangu-spacing-chinese-before-english-regexp
          (rx (group-n 1 (category japanese))
              (group-n 2 (in "a-zA-Z0-9"))))
    (setq pangu-spacing-chinese-after-english-regexp
          (rx (group-n 1 (in "a-zA-Z0-9"))
              (group-n 2 (category japanese))))
    (setq pangu-spacing-real-insert-separtor t)
    (global-pangu-spacing-mode 1)))

(defun oreore/init-mozc ()
  (use-package mozc
    :init
    (setq default-input-method "japanese-mozc")
    :hook
    (evil-insert-state-exit . my/deactivate-ime)
    :config
    (bind-keys
     :map evil-insert-state-map
     ([muhenkan] . toggle-input-method))
    (setq mozc-candidate-style 'echo-area)
    ;; Disable mozc-mode properly by [muhenkan]/[zenkaku-hankaku]
    ;; http://nos.hateblo.jp/entry/20120317/1331985029
    (defadvice mozc-handle-event (around intercept-keys (event))
      (if (member event (list 'zenkaku-hankaku 'henkan))
          (progn
            (mozc-clean-up-session)
            (toggle-input-method))
        (progn
          ;; (message "%s" event) ; debug
          ad-do-it)))
    (ad-activate 'mozc-handle-event)))
