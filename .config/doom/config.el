;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; core ----------------------------------------------------------------------------------------- ;

;; setting help
(progn
  ;; Place your private configuration here! Remember, you do not need to run 'doom
  ;; sync' after modifying this file!

  ;; Whenever you reconfigure a package, make sure to wrap your config in an
  ;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
  ;;
  ;;   (after! PACKAGE
  ;;     (setq x y))
  ;;
  ;; The exceptions to this rule:
  ;;
  ;;   - Setting file/directory variables (like `org-directory')
  ;;   - Setting variables which explicitly tell you to set them before their
  ;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
  ;;   - Setting doom variables (which start with 'doom-' or '+').
  ;;
  ;; Here are some additional functions/macros that will help you configure Doom.
  ;;
  ;; - `load!' for loading external *.el files relative to this one
  ;; - `use-package!' for configuring packages
  ;; - `after!' for running code after a package has loaded
  ;; - `add-load-path!' for adding directories to the `load-path', relative to
  ;;   this file. Emacs searches the `load-path' when you load packages with
  ;;   `require' or `use-package'.
  ;; - `map!' for binding new keys
  ;;
  ;; To get information about any of these functions/macros, move the cursor over
  ;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
  ;; This will open documentation for it, including demos of how they are used.
  ;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
  ;; etc).
  ;;
  ;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
  ;; they are implemented.
  )

;; user identity
(progn
  ;; Some functionality uses this to identify you, e.g. GPG configuration, email
  ;; clients, file templates and snippets.
  (setq user-full-name "Shun Asai")
  (setq user-login-name "shun")
  (setq user-mail-address "syun.asai@gmail.com"))

;; recentf
(after! recentf
  (use-package! recentf-ext)

  ;; (setq recentf-exclude '("/TAGS$" "/var/tmp/"))
  (setq recentf-max-saved-items 1000))

;; evil
(after! evil
  ;; Switch to the new window after splitting
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)

  ;; SPC m => ,
  (setq doom-localleader-key ",")

  ;; leader map
  (map!
   :leader
   ;; disable default
   "SPC" nil ; Find file in project
   ":" nil ; M-x
   ;; new map
   :desc "M-x" "SPC" #'execute-extended-command)

  ;; evil motion & etc
  (map!
   ;; j/k
   :m "j"  #'evil-next-visual-line
   :m "gj" #'evil-next-line
   :m "k"  #'evil-previous-visual-line
   :m "gk" #'evil-previous-line

   ;; home/end
   :mi "<home>" #'evil-first-non-blank-of-visual-line
   :m  "0"      #'evil-first-non-blank-of-visual-line
   :m  "g0"     #'evil-first-non-blank
   :m  "^"      #'evil-beginning-of-visual-line
   :m  "g^"     #'evil-digit-argument-or-evil-beginning-of-line
   :mi "<end>"  #'evil-end-of-line

   ;; paragraph
   :mi "<prior>" #'evil-backward-paragraph
   :mi "<next>"  #'evil-forward-paragraph

   ;; window navigation
   :m "<left>"  #'evil-window-left
   :m "<down>"  #'evil-window-down
   :m "<up>"    #'evil-window-up
   :m "<right>" #'evil-window-right

   ;; tab
   :m "C-<iso-lefttab>" #'+tabs:previous-or-goto
   :m "C-<tab>"         #'+tabs:next-or-goto

   ;; z prefix
   :m "z;" #'save-buffer)

  ;; - Move
  ;;   - hjkl
  ;;   - S-hjkl
  ;;   - C-S-hjkl
  ;;   - b: botom-right
  ;;   - t: top-left
  ;;   - p: mru
  ;;   - w: ace
  ;;   - M: ace-swap
  ;;   - r: rotate-downward
  ;;   - R: rotate-upward
  ;; - Resize
  ;;   - +-: height
  ;;   - <>: width
  ;;   - =:  balance
  ;;   - _:  set height
  ;;   - |:  set width
  ;;   - o:  enlarge
  ;;   - mm: maximize buffer
  ;;   - ms: maximize horizontally
  ;;   - mv: maximize vertically
  ;; - Manipulate
  ;;   - s: split
  ;;   - v: vsplit
  ;;   - d: delete
  ;;   - q: quit
  ;;   - O: delete other
  ;;   - W: ace-delete
  ;;   - n: new
  ;;   - u: undo
  (map!
   :map evil-window-map
   ;; disable overlapped map
   "c"   nil   ; evil-window-delete (d)
   "C-_" nil   ; evil-window-set-height (_)
   "C-b" nil   ; evil-window-bottom-right (b)
   "C-c" nil   ; ace-delete-window (W)
   "C-h" nil   ; evil-window-left (h)
   "C-j" nil   ; evil-window-bottom (j)
   "C-k" nil   ; evil-window-top (k)
   "C-l" nil   ; evil-window-right (l)
   "C-n" nil   ; evil-window-new (n)
   "C-o" nil   ; delete-other-windows (O)
   "C-p" nil   ; evil-window-mru (p)
   "C-s" nil   ; evil-window-split (s)
   "C-t" nil   ; evil-window-top-left (t)
   "C-u" nil   ; winner-undo (u)
   "C-v" nil   ; evil-window-vsplit (v)
   "C-w" nil   ; other-window (w)
   "C-S-r" nil ; evil-window-rotate-upwards (R)
   "C-S-s" nil ; evil-window-split (s)
   "C-S-w" nil ; ace-swap-window (M)

   ;; disable unused map
   "S"   nil ; +evil/window-split-and-follow
   "V"   nil ; +evil/window-vsplit-and-follow
   "C-f" nil ; ffap-other-window
   "C-r" nil ; winner-redo

   ;; add new map
   "M" #'ace-swap-window
   "O" #'delete-other-windows
   "w" #'ace-window
   "W" #'ace-delete-window

   (:when (modulep! :ui hydra)
    "." #'+hydra/window-nav/body)))

;; minibuffer
(after! minibuffer
  (setq completion-ignore-case t)
  (setq read-file-name-completion-ignore-case t)
  (setq read-buffer-completion-ignore-case t))

;; company
(after! company
  ;; disabled modes
  (setq company-global-modes
        '(not erc-mode message-mode help-mode helpful-mode gud-mode))

  ;; set backends for lsp
  (when (modulep! :tools lsp)
    (setq +lsp-company-backends
          '(company-files company-shell-env company-capf :with company-yasnippet :with company-dict)))

  (setq company-transformers
        '(company-sort-by-backend-importance
          company-sort-prefer-same-case-prefix))

  (setq company-idle-delay 0.1)

  ;; keymap
  (map!
   :i "C-<iso-lefttab>" #'+company/complete ; PrevTab (,)
   :map company-active-map
   ;; company-complete-common
   ;; company-complete-selection
   ;; company-filter-candidates
   ;; company-search-candidates
   ;; company-show-location
   ;; company-show-doc-buffer
   "<return>" nil
   "RET"      nil
   "<tab>"    #'company-complete-selection
   "<insert>" #'company-show-doc-buffer   ; Insert (o)
   "C-<tab>"  #'company-filter-candidates ; NextTab (.)
   "C-f"      #'company-search-candidates ; Search (/)
   ))

;; company-box
(after! company-box
  (setq company-box-doc-delay 4))

;; company-statistics
(use-package! company-statistics
  :after company
  :init
  (setq company-statistics-file (concat doom-cache-dir "company-statistics-cache.el"))
  :hook (company-mode . company-statistics-mode))

;; TODO migemo

;; org directory
(progn
  ;; If you use `org' and don't want your org files in the default location below,
  ;; change `org-directory'. It must be set before org loads!
  (setq org-directory "~/org/"))

;;; input ---------------------------------------------------------------------------------------- ;

(use-package! mozc
  :init
  (setq default-input-method "japanese-mozc")
  (map! :i [henkan] #'toggle-input-method)
  (map! :i [f12] #'toggle-input-method)

  (defun my/deactivate-ime ()
    "Deactivate IME."
    (interactive)
    (when current-input-method
      (evil-deactivate-input-method)
      (deactivate-input-method)))

  :hook
  (evil-insert-state-exit . my/deactivate-ime)

  :config
  (setq mozc-candidate-style 'echo-area)

  ;; Disable mozc-mode properly by [muhenkan]/[zenkaku-hankaku][f12]
  ;; http://nos.hateblo.jp/entry/20120317/1331985029
  (defadvice my/mozc-handle-event (around intercept-keys (event))
    (if (member event (list 'zenkaku-hankaku 'henkan 'f12))
        (progn
          (mozc-clean-up-session)
          (toggle-input-method))
      (progn
        ;; (message "%s" event) ; debug
        ad-do-it)))
  (ad-activate 'my/mozc-handle-event))

;;; editor --------------------------------------------------------------------------------------- ;

(after! auto-yasnippet
  (map!
   ;; disalbe aya-create as it's overlapped with +tabs:next-or-goto
   :after auto-yasnippet
   :nv "C-<tab>" nil))

;;; ui ------------------------------------------------------------------------------------------- ;

;; vertico-posframe
(after! vertico-posframe
  (setq vertico-posframe-border-width 3)
  (setq vertico-posframe-width 117)
  (setq vertico-posframe-min-width 117)
  (setq vertico-posframe-height 16)
  (setq vertico-posframe-min-height 16)
  (setq vertico-posframe-parameters '((left-fringe . 10) (right-fringe . 3))))

;; misc
(progn
  ;; This determines the style of line numbers in effect. If set to `nil', line
  ;; numbers are disabled. For relative line numbers, set this to `relative'.
  (setq display-line-numbers-type t)

  (setq-default fill-column 100))

;; fonts
(progn
  ;; 5 doom fonts
  ;; - `doom-font'
  ;; - `doom-variable-pitch-font'
  ;; - `doom-serif-font'
  ;; - `doom-unicode-font'
  ;; - `doom-big-font'

  ;; 4 ways to set fonts
  ;; - font-spec (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light))
  ;; - font object
  ;; - XFT font string ("Input Mono-12")
  ;; - XLFD

  ;; |---------------|
  ;; | abcdef ghijkl |
  ;; | ABCDEF GHIJKL |
  ;; |---------------|
  ;; | '";:-+ =/\~`? |
  ;; | ∞≤≥∏∑∫×±⊆⊇  |
  ;; |---------------|
  ;; | 日本語 の美観 |
  ;; | あいう えおか |
  ;; | アイウ エオカ |
  ;; | ｱｲｳｴｵｶ ｷｸｹｺｻｼ |
  ;; |---------------|

  ;; (let ((num-disp (length (display-monitor-attributes-list)))
  ;;       ;; Default font size for the Thinkpad X1 buitlin display
  ;;       (font-family-base "JetBrainsMono Nerd Font")
  ;;       (font-family-unicode "MeiryoKe_Console")
  ;;       (font-size 28)
  ;;       (font-size-big 36))
  ;;   ;; Change font size by display settings
  ;;   (cond
  ;;    ;; X1 with multiple displays
  ;;    ((and (string= (system-name) "note1") (/= num-disp 1))
  ;;     (setq font-size 15)
  ;;     (setq font-size-big 28)))

  ;;   (setq doom-font (font-spec :family font-family-base :size font-size))
  ;;   (setq doom-unicode-font (font-spec :family font-family-unicode :size font-size))
  ;;   (setq doom-big-font (font-spec :family font-family-base :size font-size-big)))

  ;; ;; Use hook to prevent font settings overriden
  ;; ;; https://github.com/hlissner/doom-emacs/issues/3298
  ;; (add-hook! 'after-setting-font-hook
  ;;   ;; (set-fontset-font nil 'japanese-jisx0213.2004-1 (font-spec :family "MeiryoKe_Console"))
  ;;   ;; (set-fontset-font nil 'katakana-jisx0201 (font-spec :family "MeiryoKe_Console"))
  ;;   (add-to-list 'face-font-rescale-alist '(".*Meiryo*." . 1.2)))

  (setq doom-font (font-spec :family "monospace" :size 17))
  (setq doom-big-font (font-spec :family "monospace" :size 36)))

;; doom-themes
(progn
  ;; There are two ways to load a theme. Both assume the theme is installed and
  ;; available. You can either set `doom-theme' or manually load a theme with the
  ;; `load-theme' function. This is the default:
  (setq doom-theme 'doom-one)

  (after! doom-themes
    (setq doom-themes-treemacs-enable-variable-pitch nil)))

;; treemacs
(progn
  ;; This must be set before treemacs has loaded
  (setq +treemacs-git-mode 'deferred) ; simple, extended or deferred

  (after! treemacs
    (setq treemacs-width 40)
    (setq treemacs-position 'right)
    (setq treemacs-collapse-dirs 0))

  (when (modulep! :ui treemacs)
    (map!
     :leader
     :desc "Project sidebar" "0" #'treemacs-select-window)))

;; centaur-tabs
(after! centaur-tabs
  (setq centaur-tabs-set-close-button nil)
  (setq centaur-tabs-label-fixed-length 12)

  ;; tab disabled modes
  (add-hook! 'special-mode-hook #'centaur-tabs-local-mode)

  (defun centaur-tabs-buffer-groups ()
    (list
     (cond
      ((memq major-mode '(slack-mode
                          slack-all-threads-buffer-mode
                          slack-file-list-buffer-mode
                          slack-message-buffer-mode
                          slack-thread-message-buffer-mode
                          slack-user-profile-buffer-mode))
       "Slack")
      ((memq major-mode '(eshell-mode
                          inferior-emacs-lisp-mode ; ielm
                          inferior-ess-r-mode
                          inferior-python-mode
                          shell-mode
                          term-mode
                          vterm-mode))
       "REPL")
      ((or (string-equal "*" (substring (buffer-name) 0 1))
           (memq major-mode '(magit-process-mode
                              magit-status-mode
                              magit-diff-mode
                              magit-log-mode
                              magit-file-mode
                              magit-blob-mode
                              magit-blame-mode)))
       "Emacs")
      ((derived-mode-p 'prog-mode)
       "Code")
      ((derived-mode-p 'dired-mode)
       "Dired")
      ((memq major-mode '(markdown-mode
                          text-mode
                          diary-mode
                          org-mode
                          org-src-mode
                          org-agenda-mode))
       "Doc")
      (t
       (centaur-tabs-get-group-name (current-buffer)))))))

;; popup
(progn
  (when (modulep! :ui popup)
    (set-popup-rules!
      '(
        ;; Show help/man page bellow the buffer
        ("^\\*[Hh]elp"
         :actions (display-buffer-reuse-window display-buffer-below-selected)
         :height 0.4
         :select t)
        ("^\\*Man"
         :actions (display-buffer-reuse-window display-buffer-below-selected)
         :height 0.4
         :select t)

        ;; Shell
        ("^\\*doom:vterm-popup:main\\*"
         :actions (display-buffer-reuse-window display-buffer-below-selected)
         :height 0.3
         :select t)
        ("^\\*doom:eshell-popup:main\\*"
         :actions (display-buffer-reuse-window display-buffer-below-selected)
         :height 0.3
         :select t)

        ;; scratch buffer
        ("^\\*doom:scratch\\*"
         :actions (display-buffer-reuse-window display-buffer-below-selected)
         :height 0.3
         :select t)
        ))

    (after! lsp-mode
      (set-popup-rules!
        '(
          ("^\\*lsp-help\\*"
           :actions (display-buffer-reuse-window display-buffer-below-selected)
           :height 0.4
           :select t)
          )))

    (after! ess
      (set-popup-rules!
        '(
          ;; R REPL
          ("^\\*R"
           :side left
           :width 120
           :quit nil
           :modeline t)
          ;; rdired
          ("^\\*R dired\\*"
           :actions (display-buffer-reuse-window display-buffer-below-selected)
           :height 0.3
           :select t)
          )))))

;;; checkers ------------------------------------------------------------------------------------- ;

(use-package! flycheck
  :init
  ;; Disable by default
  (remove-hook! 'doom-first-buffer-hook #'global-flycheck-mode))

;;; tools ---------------------------------------------------------------------------------------- ;

;; TODO lsp-mode
;; (after! lsp-mode
;;   :config
;;   (setq lsp-diagnostics-provider :none))

;; TODO dap

(after! comint
  (map!
   :map comint-mode-map
   "C-l" #'comint-clear-buffer))

;;; lang ----------------------------------------------------------------------------------------- ;

;; emacs-lisp
(progn
  (after! elisp-mode
    ;; company-backends
    (set-company-backend! '(emacs-lisp-mode lisp-interaction-mode)
      '(company-files company-dict company-capf :with company-yasnippet))))

;; TODO org
(progn
  (after! evil-org
    (map!
     :map evil-org-mode-map
     ;; Disable default RET bindings as it interferes with mozc's conversion confirmation.
     ;; Default = (cmd! (org-return electric-indent-mode))
     :i [return] nil
     :i "RET"    nil))

  (after! org-roam
    (setq org-roam-directory "~/org-roam"))

  ;; appearance
  ;; replace "-" with "•"
  ;; https://zzamboni.org/post/beautifying-org-mode-in-emacs/
  (font-lock-add-keywords
    'org-mode
    '(("^ *\\([-]\\) "
      (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  (setq org-hide-emphasis-markers t))

;; TODO sh-script
(progn
  (after! sh-script
    ;; (setq-hook! 'sh-mode
    ;;   flycheck-checker 'sh-shellcheck
    ;;   flycheck-disabled-checkers 'lsp)
    ))

;; TODO sql
(progn
  (after! sql
    ;; tab-width
    (setq-hook! 'sql-mode-hook tab-width 2)

    ;; company-backend
    (set-company-backend! 'sql-mode '(company-dict company-yasnippet))

    ;; TODO BigQuery Syntax Color キーワード
    ;; (add-to-list sql-product-alist)
    ;; (sql-add-product)
    ;; (sql-add-product-keywords)

    ;; sqls
    ;; (when (and (executable-find "sqls") (modulep! :tools lsp))
    ;;   (add-hook! 'sql-mode-hook #'lsp!)
    ;;   (setq-hook! 'sql-mode-hook +format-with-lsp nil))

    ;; formatter
    (when (modulep! :editor format)
      ;; `pgFormatter'
      ;; https://github.com/darold/pgFormatter
      (when (executable-find "pg_format")
        (set-formatter!
          'pgFormatter
          "pg_format -s 2 -g -e"
          :modes '(sql-mode)))

      ;; `pg-formatter' (npm)
      ;; https://github.com/gajus/pg-formatter
      ;; TODO file ではなく、stdin で渡す必要がある
      (when (executable-find "pg-formatter")
        (set-formatter!
          'pg-formatter
          "pg-formatter --spaces 2 --config {}"
          :modes '(sql-mode)))

      ;; `sql-formatter' (npm)
      ;; https://github.com/zeroturnaround/sql-formatter
      ;; -u spark の選定理由
      ;; (OK): `, - の前後にスペースがつかないこと
      ;; (NG): @ の前後にスペースがつかないこと
      ;; (OK): CASE ~ WHEN ~ END でインデントされる
      ;; (OK): CREATE OR REPLACE TABLE の OR の後で改行されない
      ;; (NG): JOIN ~ ON/USING で改行されないこと
      (when (executable-find "sql-formatter")
        (set-formatter!
          'sql-formatter
          "sql-formatter --config /home/shun/.config/sql-formatter/config.json"
          :modes '(sql-mode)))

      ;; `prettier-plugin-bq' (npm)
      ;; https://github.com/dr666m1/prettier-plugin-bq
      ;; TODO file ではなく、stdin で渡す必要がある
      (when (executable-find "prettier")
        (set-formatter!
          'prettier-plugin-bq
          "prettier --write"
          :modes '(sql-mode)))

      ;; `sqlfluff' (python)
      ;; https://github.com/sqlfluff/sqlfluff
      ;; (when (executable-find "sqlfluff")
      ;;   (set-formatter!
      ;;     'sqlfluff
      ;;     "sqlfluff fix"
      ;;     :modes '(sql-mode)))

      ;; set formatter
      (setq-hook! 'sql-mode-hook +format-with 'sql-formatter))

    ;; sqlup-mode
    (use-package! sqlup-mode
      :config
      (add-hook! 'sql-mode-hook 'sqlup-mode)
      (setq sqlup-blacklist
            '("hour" "date" "month" "year" "name"
              ;; for jinja/dbt
              "column_name" "source" "ref" "set" "length" "else" "not" "type" "key" "value"
              "min" "max" "user" "true" "false"
              )))

    ;; keymap
    (map!
     :after sql
     :map sql-mode-map
     :localleader
     (:prefix ("=" . "format")
      :desc "Format buffer/region" "=" #'+format/region-or-buffer))))

;; python
(progn
  (after! python
    ;; (setq python-shell-interpreter "python")
    (when (modulep! :ui popup)
      (map!
       :after python
       :map python-mode-map
       :nv "C-<return>" #'+eval/line-or-region))))

;; ess
(progn
  (after! ess
    ;;; Custom functions

    (defun my/insert-magrittr-pipe ()
      "Insert %>%"
      (interactive)
      (just-one-space 1)
      (insert "%>%"))

    (defun my/insert-R-pipe ()
      "Insert |>"
      (interactive)
      (just-one-space 1)
      (insert "|>"))

    (defun my/ess-set-comment-one-hash ()
      "コメントがデフォルトで ## になるのを # に変更する"
      (interactive)
      (set (make-local-variable 'comment-add) 0))

    (defun my/ess-r-devtools-test-file ()
      (interactive)
      (let* ((file (buffer-file-name))
             (cmd (format "testthat::test_file(\"%s\")" file)))
        (ess-execute cmd 'buffer)))

    (defun my/ess-print-at-point ()
      (interactive)
      (let ((obj (ess-read-object-name-default)))
        (ess-execute (format "%s" obj) 'buffer)))

    (defun my/ess-str-at-point ()
      (interactive)
      (let ((obj (ess-read-object-name-default)))
        (ess-execute (format "str(%s)" obj) 'buffer)))

    (defun my/ess-load-projecttemplate-project ()
      (interactive)
      (ess-execute "ProjectTemplate::load.project()" 'buffer))

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

    (defhydra my/hydra-ess-tracebug (:color pink :hint nil)
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

    ;;; settings

    (setq ess-offset-continued '(straight . 2)) ; or '(cascade . 2)
    (setq ess-eldoc-show-on-symbol t)
    (setq ess-style 'RStudio)
    (setq ess-history-file nil)
    (setq ess-eval-visibly t) ; Scroll REPL on output

    ;; comment
    (setq ess-indent-with-fancy-comments nil)
    (add-hook! 'ess-r-mode-hook #'my/ess-set-comment-one-hash)

    ;; Disable unnecessary completion
    (setq ess-use-R-completion nil)
    (setq ess-use-auto-complete nil)
    (setq ess-use-ido nil)

    ;; Object popup by tooltip
    (setq ess-describe-at-point-method 'nil) ; nil or tooltip
    ;; TODO colored str by {crayon}
    (setq ess-R-describe-object-at-point-commands
          '(("str(%s)")
            (".ess_htsummary(%s, hlength = 10, tlength = 10)")
            ("summary(%s, maxsum = 20)")))

    ;; iESS
    (set-evil-initial-state! 'inferior-ess-r-mode 'normal)

    ;;; keymap

    ;; ess-help
    (map!
     :after ess-help
     :map ess-doc-map
     "RET"        nil
     "TAB"        nil
     "C-<return>" nil
     "<down>"     nil
     "<up>"       nil
     "C-a"        nil
     "C-d"        nil
     "C-e"        nil
     "C-o"        nil
     "C-v"        nil
     "C-w"        nil
     "d"          nil
     "m"          nil
     "p"          nil
     "t"          nil)

    ;; rdired
    (map!
     ;; Normal mode でも使えるようにする
     :after ess-rdired
     :map ess-rdired-mode-map
     :n "d" #'ess-rdired-delete
     :n "p" #'ess-rdired-plot
     :n "r" #'revert-buffer
     :n "v" #'my/ess-print-at-point
     :n "x" #'ess-rdired-delete)

    ;; ess-dev
    (map!
     :map ess-dev-map
     "C-b" nil
     "C-d" nil
     "C-e" nil
     "C-k" nil
     "C-l" nil
     "C-n" nil
     "C-o" nil
     "C-p" nil
     "C-s" nil
     "C-u" nil
     "C-w" nil
     "."   #'my/hydra-ess-tracebug/body
     :map ess-debug-minor-mode-map
     "M-S" #'my/ess-debug-command-step-into)

    ;; ess-extra
    (map!
     :map ess-extra-map
     "b"   #'ess-eval-buffer
     "f"   #'ess-eval-function
     "g"   #'ess-eval-buffer-from-beg-to-here
     "G"   #'ess-eval-buffer-from-here-to-end
     "s"   #'ess-switch-process
     "S"   #'ess-set-style
     "p"   #'my/ess-load-projecttemplate-project
     "TAB" nil
     "C-d" nil
     "C-e" nil
     "C-l" nil
     "C-r" nil
     "C-s" nil
     "C-t" nil
     "C-w" nil)

    ;; ess-r-package-dev
    (map!
     :map ess-r-package-dev-map
     "C-a"   nil
     "C-b"   nil
     "C-c"   nil
     "c C-c" nil
     "c C-w" nil
     "C-d"   nil
     "C-e"   nil
     "C-l"   nil
     "C-s"   nil
     "C-t"   nil
     "C-u"   nil
     "f"     #'my/ess-r-devtools-test-file)

    (map!
     :map ctbl:table-mode-map
     :n "q" #'kill-this-buffer)

    ;; iESS
    (map!
     :map inferior-ess-r-mode-map
     :i "," #'ess-smart-comma

     :localleader
     :map inferior-ess-r-mode-map
      "."   #'ess-describe-object-at-point
      "TAB" #'ess-switch-to-inferior-or-script-buffer)

    (map!
     :map ess-mode-map
     :i "C->"        #'my/insert-magrittr-pipe
     :i "C-|"        #'my/insert-R-pipe
     :m "C-<return>" #'ess-eval-region-or-line-visibly-and-step

     :localleader
     :map ess-mode-map
     ;; disable default bindings
     [tab] nil
     [backtab] nil
     "b" nil
     "B" nil
     "d" nil
     "D" nil
     "f" nil
     "F" nil
     "l" nil
     "L" nil
     "r" nil
     "R" nil

     ;; new mapping
     ","   #'ess-eval-region-or-function-or-paragraph-and-step
     "."   #'ess-describe-object-at-point
     ";"   #'my/ess-print-at-point
     "["   #'my/ess-str-at-point
     "0"   #'ess-rdired
     "TAB" #'ess-switch-to-inferior-or-script-buffer

     ;; predefined map
     "d" #'ess-dev-map
     "e" #'ess-extra-map
     "h" #'ess-doc-map
     "p" #'ess-r-package-dev-map
     "v" nil ; v=view
     "x" nil

     "sp" #'my/ess-print-at-point
     "sr" #'my/ess-str-at-point
     "st" #'ess-R-dv-ctable
     "ss" #'ess-r-spreadsheet

     ;; ess-mode に対して prefix を設定するとなぜか反映されないので、ess-r-mode に設定する
     :map ess-r-mode-map
     (:prefix ("c" . "noweb"))
     (:prefix ("d" . "debug"))
     (:prefix ("e" . "eval"))
     (:prefix ("h" . "help"))
     (:prefix ("p" . "package-dev"))
     (:prefix ("pc" . "check"))
     (:prefix ("s" . "show")))
    )

  (use-package! ess-smart-equals
    :hook
    ((ess-r-mode . ess-smart-equals-mode)
     (inferior-ess-r-mode . ess-smart-equals-mode))))
