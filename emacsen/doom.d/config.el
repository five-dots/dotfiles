;;; Dropbox/repos/github/five-dots/dotfiles/doom.d/config.el -*- lexical-binding: t; -*-
;; Place your private configuration here

(load (expand-file-name "~/Dropbox/repos/github/five-dots/dotfiles/emacsen/elisp/vars.el"))
(load (expand-file-name "vars-secret.el" my/elisp-dir))
(load (expand-file-name "funcs" my/elisp-dir))


;;; completion

;; FIXME show-doc
(after! company
  (setq completion-ignore-case t)
  (setq read-file-name-completion-ignore-case t)
  (setq read-buffer-completion-ignore-case t)
  (setq company-idle-delay 0.1)
  ;; company backend (non-lsp)
  (set-company-backend! 'emacs-lisp-mode
    '(company-capf company-files :with company-yasnippet))
  (set-company-backend! 'org-mode
    '(company-dabbrev company-files company-yasnippet))
  (when (featurep! :lang ess)
    (set-company-backend! 'ess-r-mode
      '(company-capf company-files company-yasnippet)))
  (set-company-backend! 'stan-mode
    '(company-stan-backend company-files company-yasnippet)))

(use-package! company-lsp
  :init
  (setq +lsp-company-backend
        '(company-lsp company-files :with company-yasnippet)))

(after! ivy
  (setq ivy-use-virtual-buffers t)
  (setq counsel-yank-pop-separator "\n--------------------\n")
  (add-to-list 'ivy-height-alist
               '(counsel-yank-pop . 15)))

(use-package! ivy-posframe
  :config
  (setq ivy-posframe-border-width 1)
  (setq ivy-posframe-min-width 90)
  (setq ivy-posframe-min-height 11)
  (setq ivy-posframe-height 11)
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
  (ivy-posframe-cursor ((t (:background "#61bfff")))))

(after! yasnippet
  (add-to-list 'yas-snippet-dirs my/snippets-dir))


;;; ui

(after! treemacs
  (setq treemacs-show-cursor t)
  (setq treemacs-position 'right)
  (treemacs-resize-icons 18))

(use-package! hide-mode-line
  :hook (treemacs-mode . hide-mode-line-mode))

(use-package! page-break-lines
  :config
  (dolist (mode '(ess-r-mode python-mode))
    (add-to-list 'page-break-lines-modes mode))
  (global-page-break-lines-mode))

;; font
(let ((num-disp (length (display-monitor-attributes-list)))
      (font-size 13)) ; default font height (size)
  ;; High DPI and no external display
  (when (and (equal (system-name) "x1") (= num-disp 1))
    (setq font-size 19))
  (setq doom-font (font-spec :family "Consolas NF" :size font-size))
  (setq doom-unicode-font (font-spec :family "MeiryoKe_Console" :size font-size))
  ;; |abcdef ghijkl|
  ;; |ABCDEF GHIJKL|
  ;; |'";:-+ =/\~`?|
  ;; |αβγδεζ ηθικλμ|
  ;; |ΑΒΓΔΕΖ ΗΘΙΚΛΜ|
  ;; |日本語 の美観|
  ;; |あいう えおか|
  ;; |アイウ エオカ|
  ;; |ｱｲｳｴｵｶ ｷｸｹｺｻｼ|
  (add-to-list 'face-font-rescale-alist '(".*Meiryo*." . 1.09)))

(when window-system
  (set-frame-size (selected-frame) 100 40))


;;; tools

(when (featurep! :ui popup)
  (set-popup-rules!
    '(
      ;; TODO inferior-ess-r-mode, ess-r-help-mode
      ("^\\*help[R](" :ignore t :side right :select t)
      ("^\\*R" :ignore t)
      ("^\\*ess-describe\\*$" :ignore t) ; ess-describe-object-at-point
      ("^\\*General Keybindings\\*$" :ignore t)
      ("^\\*lsp session\\*$" :ignore t)
      ;; TODO company-diag
      ;; TODO google-translate
      ;; TODO company-doc
      )))

(use-package! google-this
  :defer t)

(use-package! google-translate
  :init
  (setq google-translate-pop-up-buffer-set-focus t)
  (setq google-translate-default-source-language "en")
  (setq google-translate-default-target-language "ja"))

(use-package! dap-mode
  :defer t
  :hook (lsp-mode . dap-mode)
  :init
  (setq dap-utils-extension-path doom-etc-dir)
  (setq dap-gdb-lldb-path
        (expand-file-name "vscode/webfreak.debug" dap-utils-extension-path))
  (use-package! dap-ui
    :hook (dap-mode . dap-ui-mode))
  (use-package! dap-python
    :config
    (setq dap-python-executable "python3"))
  (use-package! dap-gdb-lldb)
  :config
  (setq dap-breakpoints-file
        (expand-file-name "dap-breakpoints" doom-cache-dir)))

(use-package! flycheck
  :hook
  (ess-r-mode . flycheck-mode)
  :config
  ;; Disable specific linters from the default
  (setq flycheck-lintr-linters
        "default_linters[-which(names(default_linters) == 'commented_code_linter')]"))

(use-package! skk
  :disabled t
  :load-path ".local/straight/build/ddskk"
  :defer t
  :commands skk-mode

  :hook
  ;; Always start using latin mode
  (evil-insert-state-entry . skk-mode)
  ;; Disable skk mode when entering normal state
  (evil-normal-state-entry . (lambda () (skk-mode -1)))
  (skk-mode . skk-latin-mode-on)

  :init
  (setq default-input-method "japanese-skk")
  :config
  ;; No new line by kakutei
  (setq skk-egg-like-newline t)
  ;; Henkan candidates
  (setq skk-show-inline t)
  ;; Cursor color
  (setq skk-cursor-hiragana-color "yellow")
  (setq skk-cursor-katakana-color "blue violet")
  ;; Record file
  (setq skk-record-file "~/Dropbox/skk/record")

  ;;; Jisyo
  (setq skk-save-jisyo-instantly t)
  ;; Personal jisyo
  (setq skk-jisyo "~/Dropbox/skk/jisyo/skk-jisyo")
  (setq skk-backup-jisyo "~/Dropbox/skk/jisyo/skk-jisyo.bak")
  ;; large jisyo
  (setq skk-large-jisyo "~/Dropbox/skk/jisyo/SKK-JISYO.L")
  ;; Extra jisyo
  ;; (setq skk-extra-jisyo-file-list
  ;;       (list "~/Dropbox/skk/jisyo/SKK-JISYO.JIS2"
  ;;       '("~/Dropbox/skk/jisyo/SKK-JISYO.JIS3_4" . euc-jisx0213)
  ;;       "~/Dropbox/skk/jisyo/SKK-JISYO.assoc"
  ;;       "~/Dropbox/skk/jisyo/SKK-JISYO.notes"
  ;;       "~/Dropbox/skk/jisyo/SKK-JISYO.geo"
  ;;       "~/Dropbox/skk/jisyo/SKK-JISYO.hukugougo"
  ;;       "~/Dropbox/skk/jisyo/SKK-JISYO.jinmei"
  ;;       "~/Dropbox/skk/jisyo/SKK-JISYO.law"
  ;;       "~/Dropbox/skk/jisyo/SKK-JISYO.lisp"
  ;;       "~/Dropbox/skk/jisyo/SKK-JISYO.okinawa"
  ;;       "~/Dropbox/skk/jisyo/SKK-JISYO.propernoun"
  ;;       "~/Dropbox/skk/jisyo/SKK-JISYO.pubdic+"
  ;;       "~/Dropbox/skk/jisyo/SKK-JISYO.station"
  ;;       "~/Dropbox/skk/jisyo/SKK-JISYO.zipcode"
  ;;       "~/Dropbox/skk/jisyo/SKK-JISYO.office.zipcode"))
  ;; saving skk jisyo ... done というメッセージが表示されるのを省略
  ;; http://slackwareirregulars.blogspot.com/2018/03/skk.html
  (defun skk-save-jisyo (&optional quiet)
    (interactive "P")
    (funcall skk-save-jisyo-function 'quiet))
  ;; skk の ▽ フォントを確実に変更する
  (add-hook 'skk-load-hook
            (λ! (set-fontset-font nil '#x25bd (font-spec :family "MeiryoKe_Console")))))

(use-package! pangu-spacing
  :init
  (setq pangu-spacing-chinese-before-english-regexp
        (rx (group-n 1 (category japanese))
            (group-n 2 (in "a-zA-Z0-9"))))
  (setq pangu-spacing-chinese-after-english-regexp
        (rx (group-n 1 (in "a-zA-Z0-9"))
            (group-n 2 (category japanese))))
  (setq pangu-spacing-real-insert-separtor t)
  (global-pangu-spacing-mode 1))

;; TODO enable in minibuffer
(use-package! mozc
  ;; :disabled t
  :init
  (setq default-input-method "japanese-mozc")
  :hook
  (evil-insert-state-exit . my/deactivate-ime)
  :config
  (setq mozc-candidate-style 'echo-area)
  ;; Disable mozc-mode properly by [muhenkan]/[zenkaku-hankaku]
  ;; http://nos.hateblo.jp/entry/20120317/1331985029
  (defadvice mozc-handle-event (around intercept-keys (event))
    (if (member event (list 'zenkaku-hankaku 'henkan))
        (progn
          (mozc-clean-up-session)
          (toggle-input-method))
      (progn
        ; (message "%s" event) ; debug
        ad-do-it)))
  (ad-activate 'mozc-handle-event))


;;; lang
(use-package! org
  :hook
  (org-mode . visual-line-mode)
  ;; (org-babel-after-execute . my/org-redisplay-inline-images)
  :config
  ;; Replace "-" with "•"
  (font-lock-add-keywords
   'org-mode
   '(("^ *\\([-]\\) "
      (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (setq org-hide-emphasis-markers t)
  ;; faces
  (set-face-attribute 'org-level-1 nil :slant 'italic :height 1.0)
  ;; (set-face-attribute 'org-block-end-line nil :foreground "#23272e")

  ;;; org-agenda
  ;; Add agenda file recursively
  ;; (setq org-agenda-files
  ;; (apply 'append
  ;;         (mapcar (lambda (directory)
  ;;       (directory-files-recursively directory org-agenda-file-regexp))
  ;;           '("~/Dropbox/memo"))))
  ;; agenda format
  ;; (setq org-agenda-prefix-format
  ;;       (quote
  ;;        ((agenda . " %i %-12:c%?12t% s")
  ;;         (todo   . " %i %-12:c")
  ;;         (tags   . " %i %-12:c")
  ;;         (search . " %i %-12:c"))))
  ;; (set-face-attribute 'org-block-end-line nil :foreground "#23272e")

  ;; Latex preview
  ;; (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-preview-latex-image-directory "~/Dropbox/memo/img/latex/"))

(after! org-bullets
  (setq org-bullets-bullet-list '("" "" "" "" "" "" "" "" "" "")))

;; TODO Complete hydra map for ess-tracebug
(after! ess
  (setq ess-offset-continued '(straight . 2)) ; or '(cascade . 2)
  (setq ess-eldoc-show-on-symbol t)
  (setq ess-history-file nil)
  (setq ess-use-R-completion nil)
  (setq ess-use-auto-complete nil)
  (setq ess-use-ido nil)

  ;; object popup by tooltip
  (setq ess-describe-at-point-method nil)
  (setq x-gtk-use-system-tooltips nil)
  (setq tooltip-hide-delay 10)
  (setq ess-R-describe-object-at-point-commands
        '(("str(%s)")
          (".ess_htsummary(%s, hlength = 5, tlength = 5)")
          ("summary(%s, maxsum = 20)")))

  (evil-set-initial-state 'inferior-ess-r-mode 'normal)
  ;; (evil-define-key 'normal ctbl:table-mode-map
  ;;   "q" 'kill-this-buffer)

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
      ("q" nil "Close" :color blue)))

(use-package! ess-smart-equals
  :hook
  ((ess-r-mode . ess-smart-equals-mode)
   (inferior-ess-r-mode . ess-smart-equals-mode)
   (ess-r-transcript-mode . ess-smart-equals-mode)))

(use-package! ess-r-spreadsheet
  :after (:any ess-r-mode inferior-ess-r-mode ess-r-transcript)
  :commands (ess-r-spreadsheet))

(use-package! stan-mode
  :mode ("\\.stan\\'" . stan-mode)
  :hook (stan-mode . stan-mode-setup)
  ;; company
  :init
  (use-package! company-stan
    :load-path ".local/straight/repos/stan-mode/company-stan"
    :hook (stan-mode . company-stan-setup)
    :config
    (setq company-stan-fuzzy nil))
  :config
  (setq stan-indentation-offset 2)
  ;; Add snippets dir
  (add-to-list
   'yas-snippet-dirs
   (expand-file-name
    "straight/repos/stan-mode/stan-snippets/snippets"
    doom-local-dir)))

(when (featurep! :lang python)
  ;; (add-to-list 'python-shell-completion-native-disabled-interpreters "python3")
  ;; (setq python-shell-interpreter-args "-i")
  (setq org-babel-python-command "python3")

  ;; https://github.com/jorgenschaefer/elpy/issues/733
  (setq python-shell-prompt-detect-enabled nil)
  (setq python-shell-prompt-detect-failure-warning nil))

(use-package! crontab-mode
  :mode (("\\.cron\\(tab\\)?\\'" . crontab-mode)
         ("cron\\(tab\\)?\\." . crontab-mode)))


;;; keymap
;; TODO prefix: g, z, [, ], @(macro)

;; global
(map!
 :nv "H"  #'evil-first-non-blank-of-visual-line
 :nv "J"  #'evil-forward-paragraph
 :nv "K"  #'evil-backward-paragraph
 :nv "L"  #'evil-end-of-visual-line
 :nv "j"  #'evil-next-visual-line
 :nv "k"  #'evil-previous-visual-line
 :nv "gj" #'evil-next-line
 :nv "gk" #'evil-previous-line
 :n "C-M-h" #'evil-window-left
 :n "C-M-j" #'evil-window-down
 :n "C-M-k" #'evil-window-up
 :n "C-M-l" #'evil-window-right)

;; leader
(map!
 :leader
 :desc "M-x"                   "SPC" #'execute-extended-command
 :desc "Project sidebar"       "0"   #'treemacs-select-window
 :desc "Switch buffer"         ","   #'switch-to-buffer
 :desc "Switch to last buffer" "TAB" #'evil-switch-to-windows-last-buffer
 :desc "Resume last search"    "."
 (cond ((featurep! :completion ivy) #'ivy-resume)
       ((featurep! :completion helm) #'helm-resume))
 ;; workspace
 (:when (featurep! :ui workspaces)
   :desc "Switch workspace buffer" "<" #'persp-switch-to-buffer
   :desc "Switch buffer" "," #'switch-to-buffer
   (:prefix-map ("W" . "workspace")
     :desc "Display tab bar"           "TAB" #'+workspace/display
     :desc "Switch workspace"          "."   #'+workspace/switch-to
     :desc "Switch to last workspace"  "`"   #'+workspace/other
     :desc "New workspace"             "n"   #'+workspace/new
     :desc "Load workspace from file"  "l"   #'+workspace/load
     :desc "Save workspace to file"    "s"   #'+workspace/save
     :desc "Delete session"            "x"   #'+workspace/kill-session
     :desc "Delete this workspace"     "d"   #'+workspace/delete
     :desc "Rename workspace"          "r"   #'+workspace/rename
     :desc "Restore last session"      "R"   #'+workspace/restore-last-session
     :desc "Next workspace"            "]"   #'+workspace/switch-right
     :desc "Previous workspace"        "["   #'+workspace/switch-left
     :desc "Switch to 1st workspace"   "1"   #'+workspace/switch-to-0
     :desc "Switch to 2nd workspace"   "2"   #'+workspace/switch-to-1
     :desc "Switch to 3rd workspace"   "3"   #'+workspace/switch-to-2
     :desc "Switch to 4th workspace"   "4"   #'+workspace/switch-to-3
     :desc "Switch to 5th workspace"   "5"   #'+workspace/switch-to-4
     :desc "Switch to 6th workspace"   "6"   #'+workspace/switch-to-5
     :desc "Switch to 7th workspace"   "7"   #'+workspace/switch-to-6
     :desc "Switch to 8th workspace"   "8"   #'+workspace/switch-to-7
     :desc "Switch to 9th workspace"   "9"   #'+workspace/switch-to-8
     :desc "Switch to final workspace" "0"   #'+workspace/switch-to-final))
 ":" nil
 "'" nil
 "`" nil
 ;; google search
 (:prefix-map ("/ g " . "google")
   "g" #'google-this
   "t" #'google-translate-at-point
   "T" #'google-translate-at-point-reverse
   "q" #'google-translate-query-translate
   "Q" #'google-translate-query-translate-reverse))

;; company
(map!
 (:after company
   :i "M-," #'+company/complete
   (:map company-active-map
     "C-SPC" #'company-complete-common
     "TAB"   #'company-complete-selection
     [tab]   #'company-complete-selection
     "M-."   #'company-filter-candidates
     "M-/"   #'company-search-candidates
     "M-d"   #'company-next-page
     "M-i"   #'company-show-doc-buffer
     ;; "M-p"   #'company-quickhelp-manual-begin
     "M-u"   #'company-previous-page
     "M-w"   #'company-show-location
     "M-n"   nil
     "M-p"   nil
     "M-v"   nil)))

;; treemacs
(map!
 (:when (featurep! :ui treemacs)
   (:map treemacs-mode-map
     "C-M-h" #'evil-window-left
     "C-M-h" #'evil-window-left
     "C-M-j" #'evil-window-down
     "C-M-k" #'evil-window-up
     "C-M-l" #'evil-window-right)))

;; evil-window-map
(map!
 (:map evil-window-map
   "d" #'evil-quit
   "m" #'ace-swap-window
   "O" #'delete-other-windows
   "w" #'ace-window
   "W" #'ace-delete-window
   "C-_" nil
   "C-b" nil
   "C-c" nil
   "C-f" nil
   "C-h" nil
   "C-j" nil
   "C-k" nil
   "C-l" nil
   "C-n" nil
   "C-o" nil
   "C-p" nil
   "C-r" nil
   "C-s" nil
   "C-t" nil
   "C-u" nil
   "C-v" nil
   "C-w" nil
   "C-S-r" nil
   "C-S-s" nil
   "C-S-w" nil))

;; emacs-lisp-mode-map
(map!
 :localleader
 (:map emacs-lisp-mode-map
   :nv "h" #'helpful-at-point
   (:prefix-map ("e" . "eval")
     :nv "b" #'eval-buffer
     :nv "e" #'eval-last-sexp
     :nv "f" #'eval-defun
     :nv "r" #'eval-region
     :nv "x" #'lispxmp)))

;; org-mode-map
;; TODO complete keymap
(map!
 (:after org
   :localleader
   (:map org-mode-map
     "," #'org-ctrl-c-ctrl-c)))

;; ddskk
(map!
 (:after skk
   :i "C-j" nil ; disable +default/newline
   (:map skk-latin-mode-map
     [muhenkan] #'skk-kakutei)))

;; mozc
(map!
 (:after mozc
   :i [muhenkan] #'toggle-input-method
   :i [henkan] #'my/deactivate-ime))

;; ess
;; TODO ess-watch-mode-map and others
(map!
 (:after ess
   (:map ess-dev-map
     "."   #'hydra-ess-tracebug/body
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
     "C-w" nil)

   (:map ess-extra-map
     "b"   #'ess-eval-buffer
     "f"   #'ess-eval-function
     "s"   #'ess-switch-process
     "S"   #'ess-set-style
     "TAB" nil
     "C-d" nil
     "C-e" nil
     "C-l" nil
     "C-r" nil
     "C-s" nil
     "C-t" nil
     "C-w" nil)

   (:map ess-doc-map
     "RET" nil
     "TAB" nil
     [C-return] nil
     [down] nil
     [up] nil
     "C-a" nil
     "C-d" nil
     "C-e" nil
     "C-o" nil
     "C-v" nil
     "C-w" nil
     "d" nil
     "m" nil
     "p" nil
     "t" nil)

   (:map ess-r-package-dev-map
       "C-a" nil
       "C-b" nil
       "C-c" nil
       "c C-c" nil
       "c C-w" nil
       "C-d" nil
       "C-e" nil
       "C-l" nil
       "C-s" nil
       "C-t" nil
       "C-u" nil)

   (:map inferior-ess-r-mode-map
     :i "," #'ess-smart-comma)

   :nv "<C-return>" nil ; disable +default/newline-below
   :i "C->" #'my/insert-R-pipe
   :localleader
   (:map ess-r-mode-map
     ","   #'ess-eval-region-or-function-or-paragraph
     "."   #'ess-describe-object-at-point
     "TAB" #'ess-switch-to-inferior-or-script-buffer

     ;; predefined map
     "d" #'ess-dev-map           ; d=debug
     "e" #'ess-extra-map         ; e=eval
     "h" #'ess-doc-map           ; h=help
     "p" #'ess-r-package-dev-map ; p=package-dev
     "v" nil                     ; v=view
     "x" nil

     [tab] nil
     [backtab] nil
     "b" nil
     "B" nil
     "D" nil
     "f" nil
     "F" nil
     "l" nil
     "L" nil
     "r" nil
     "R" nil

     (:prefix ("c" . "chunk"))
     (:prefix ("d" . "debug"))
     (:prefix ("e" . "eval"))
     (:prefix ("h" . "help"))
     (:prefix ("p" . "package-dev"))
     (:prefix ("pc" . "check"))
     (:prefix ("s" . "show")
       "p" #'ess-R-dv-pprint
       "t" #'ess-R-dv-ctable
       "s" #'ess-r-spreadsheet
       ))

   :localleader
   (:map inferior-ess-r-mode-map
     ","   #'ess-smart-comma
     "."   #'ess-describe-object-at-point
     "TAB" #'ess-switch-to-inferior-or-script-buffer))

 (:after ess-help
   :map ess-r-help-mode-map
   :n "J" #'ess-skip-to-next-section
   :n "K" #'ess-skip-to-previous-section
   :n "W" #'ess-display-help-in-browser))

;; comint-mode
(map!
 (:map comint-mode-map
   :n "C-M-h" #'evil-window-left
   :n "C-M-j" #'evil-window-down
   :n "C-M-k" #'evil-window-up
   :n "C-M-l" #'evil-window-right
   :ni "C-l"  #'comint-clear-buffer))

;; omnisharp
(map!
 (:after omnisharp
   :localleader
   (:map omnisharp-mode-map
     (:prefix ("g" . "goto"))
     (:prefix ("r" . "refactor"))
     (:prefix ("t" . "test")))))
