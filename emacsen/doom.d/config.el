;;; Dropbox/repos/github/five-dots/dotfiles/doom.d/config.el -*- lexical-binding: t; -*-
;; Place your private configuration here

(load (expand-file-name "~/Dropbox/repos/github/five-dots/dotfiles/emacsen/elisp/vars.el"))
(load (expand-file-name "vars-secret.el" my/elisp-dir))
(load (expand-file-name "funcs" my/elisp-dir))


;;; completion

;; TODO keyword :with, :separate etc.
;; TODO show-doc
(after! company
  (setq completion-ignore-case t)
  (setq read-file-name-completion-ignore-case t)
  (setq read-buffer-completion-ignore-case t)
  (setq company-idle-delay 0.1)
  ;; company backend (non-lsp)
  (set-company-backend! 'emacs-lisp-mode
    '(company-capf company-files company-yasnippet))
  (set-company-backend! 'org-mode
    '(company-dabbrev company-files company-yasnippet))
  (when (featurep! :lang ess)
    (set-company-backend! 'ess-r-mode
      '(company-capf company-dabbrev company-files company-yasnippet)))
  (set-company-backend! 'stan-mode
    '(company-stan-backend company-dabbrev company-files company-yasnippet))
  (map!
   (:when (featurep! :completion company)
     "M-," #'+company/complete
     (:after company
       (:map company-active-map
         "C-SPC" #'company-complete-common
         "TAB"   #'company-complete-selection
         [tab]   #'company-complete-selection
         "M-."   #'company-filter-candidates
         "M-/"   #'company-search-candidates
         "M-d"   #'company-next-page
         "M-i"   #'company-show-doc-buffer
         "M-u"   #'company-previous-page
         "M-w"   #'company-show-location)))))

(use-package! company-lsp
  :init
  (setq +lsp-company-backend
        '(company-lsp company-dabbrev company-files company-yasnippet)))

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
  (treemacs-resize-icons 18)
  (map!
   (:when (featurep! :ui treemacs)
     (:map treemacs-mode-map
       "C-M-h" #'evil-window-left))))

(use-package! hide-mode-line
  :hook (treemacs-mode . hide-mode-line-mode))

(use-package! page-break-lines
  :config
  (add-to-list 'page-break-lines-modes 'ess-r-mode)
  (add-to-list 'page-break-lines-modes 'python-mode)
  (global-page-break-lines-mode))

;; font
(let ((num-disp (length (display-monitor-attributes-list)))
      (font-size 13)) ; default font height (size)
  ;; High DPI and no external display
  (when (and (equal (system-name) "x1") (= num-disp 1))
    (setq font-size 19))
  (setq doom-font (font-spec :family "Consolas NF" :size font-size))
  (setq doom-unicode-font (font-spec :family "MeiryoKe_Console" :size font-size))
  ;; skk の ▽ フォントを確実に変更する
  (add-hook 'skk-load-hook
            (λ! (set-fontset-font nil '#x25bd (font-spec :family "MeiryoKe_Console"))))
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
  (set-frame-size (selected-frame) 120 50))


;;; tools

(when (featurep! :ui popup)
  (set-popup-rules!
    '(
      ("^\\*help[R](" :ignore t :side right :select t)
      ("^\\*R" :ignore t)
      ("^\\*ess-describe\\*$" :ignore t) ; ess-describe-object-at-point
      ("^\\*General Keybindings\\*$" :ignore t)
      ("^\\*lsp session\\*$" :ignore t)
      ;; TODO google-translate
      ;; TODO company-doc
      )))

(use-package! google-this
  :defer t
  :init
  (map!
   :leader
   (:prefix-map ("/ g " . "google")
     "g" #'google-this)))

(use-package! google-translate
  :init
  (setq google-translate-pop-up-buffer-set-focus t)
  (setq google-translate-default-source-language "en")
  (setq google-translate-default-target-language "ja")
  (map!
   :leader
   (:prefix-map ("/ g " . "google")
     "t" #'google-translate-at-point
     "T" #'google-translate-at-point-reverse
     "q" #'google-translate-query-translate
     "Q" #'google-translate-query-translate-reverse)))

(use-package! dap-mode
  :defer t
  :hook (lsp-mode . dap-mode)
  :init
  (setq dap-utils-extension-path
        (expand-file-name "extension" doom-local-dir))
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

(use-package! skk
  :load-path ".local/straight/build/ddskk"
  :defer t
  :commands skk-mode
  :hook
  ;; Always start using latin mode
  (evil-insert-state-entry . skk-mode)
  (skk-mode . skk-latin-mode-on)
  :init
  (setq default-input-method "japanese-skk")
  :config
  ;; Henkan candidates
  (setq skk-show-inline t)
  ;; Cursor color
  (setq skk-cursor-hiragana-color "yellow")
  (setq skk-cursor-katakana-color "blue violet")
  ;; Record file
  (setq skk-record-file "~/Dropbox/skk/record")
  ;; Personal jisyo
  (setq skk-jisyo "~/Dropbox/skk/jisyo/skk-jisyo")
  (setq skk-backup-jisyo "~/Dropbox/skk/jisyo/skk-jisyo.bak")
  ;; large jisyo
  (setq skk-large-jisyo "~/Dropbox/skk/jisyo/SKK-JISYO.L")
  ;; Extra jisyo
  (setq skk-extra-jisyo-file-list
        (list "~/Dropbox/skk/jisyo/SKK-JISYO.JIS2"
        '("~/Dropbox/skk/jisyo/SKK-JISYO.JIS3_4" . euc-jisx0213)
        "~/Dropbox/skk/jisyo/SKK-JISYO.assoc"
        "~/Dropbox/skk/jisyo/SKK-JISYO.notes"
        "~/Dropbox/skk/jisyo/SKK-JISYO.geo"
        "~/Dropbox/skk/jisyo/SKK-JISYO.hukugougo"
        "~/Dropbox/skk/jisyo/SKK-JISYO.jinmei"
        "~/Dropbox/skk/jisyo/SKK-JISYO.law"
        "~/Dropbox/skk/jisyo/SKK-JISYO.lisp"
        "~/Dropbox/skk/jisyo/SKK-JISYO.okinawa"
        "~/Dropbox/skk/jisyo/SKK-JISYO.propernoun"
        "~/Dropbox/skk/jisyo/SKK-JISYO.pubdic+"
        "~/Dropbox/skk/jisyo/SKK-JISYO.station"
        "~/Dropbox/skk/jisyo/SKK-JISYO.zipcode"
        "~/Dropbox/skk/jisyo/SKK-JISYO.office.zipcode"))
  ;; Disable skk mode when entering normal state
  (add-hook 'evil-normal-state-entry-hook
            '(lambda () (when skk-mode (skk-mode -1))))
  ;; saving skk jisyo ... done というメッセージが表示されるのを省略
  ;; http://slackwareirregulars.blogspot.com/2018/03/skk.html
  (defun skk-save-jisyo (&optional quiet)
    (interactive "P")
    (funcall skk-save-jisyo-function 'quiet)))

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

(use-package! mozc
  :disabled t
  :config
  (defun my/deactivate-ime ()
    "Deactivate IME"
    (interactive)
    (when current-input-method
      (evil-deactivate-input-method)
      (deactivate-input-method)))
  (setq default-input-method "japanese-mozc")
  (setq mozc-candidate-style 'echo-area)
  ;; mozc.el で無変換キー/全角半角キーでちゃんと mozc-mode を切る
  ;; http://nos.hateblo.jp/entry/20120317/1331985029
  (defadvice mozc-handle-event (around intercept-keys (event))
    (if (member event (list 'zenkaku-hankaku 'henkan))
        (progn
          (mozc-clean-up-session)
          (toggle-input-method))
      (progn
        ; (message "%s" event) ; debug
        ad-do-it)))
  (ad-activate 'mozc-handle-event)
  ;; Disable IME w/o insert mode
  (add-hook 'evil-insert-state-exit-hook 'my/deactivate-ime)
  (map!
   :i [muhenkan] #'toggle-input-method
   :i [henkan] #'my/deactivate-ime))


;;; lang
(after! org
  ;;; Appearance
  ;; Replace "-" with "•"
  (font-lock-add-keywords
   'org-mode
   '(("^ *\\([-]\\) "
      (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (setq org-hide-emphasis-markers t)

  ;;; faces
  (set-face-attribute 'org-level-1 nil :slant 'italic :height 1.1)
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

  ;;; Latex preview
  (setq org-preview-latex-image-directory "~/Dropbox/memo/img/latex/")
  ;; (setq org-preview-latex-default-process 'dvisvgm)

  ;; Custom function to get ramdom file name
  (cl-defun my/get-babel-file
    (&key
     (dir (expand-file-name "~/Dropbox/memo/img/babel/"))
     (prefix "fig-")
     (suffix ".png"))
    (concat dir (make-temp-name prefix) suffix))
  (defalias 'get-babel-file 'my/get-babel-file)

  ;; Update inline images
  (defun my/org-redisplay-inline-images ()
    (when org-inline-image-overlays
      (org-redisplay-inline-images)))
  (add-hook 'org-babel-after-execute-hook 'my/org-redisplay-inline-images))

(after! org-bullets
  (setq org-bullets-bullet-list '("" "" "" "" "" "" "" "" "" "")))

(after! ess
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
          (".ess_htsummary(%s, hlength = 14, tlength = 14)")
          ("summary(%s, maxsum = 20)")))
  ;; ess spreadsheet
  (add-to-list 'load-path (expand-file-name "~/Dropbox/repos/private/elisp/ess-spreadsheet"))
  (require 'ess-spreadsheet)

  (map!
   :localleader
   :map ess-r-mode-map
   "." #'ess-describe-object-at-point
   ;; predefined map
   "d" #'ess-dev-map
   "h" #'ess-doc-map
   "p" #'ess-r-package-dev-map
   "x" #'ess-extra-map
   "v" nil

   ;; disable unsed mappings
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

   (:prefix ("e" . "eval")
     "b" #'ess-eval-buffer
     "f" #'ess-eval-function
     "s" #'ess-switch-to-inferior-or-script-buffer
     "S" #'ess-switch-process)

   (:prefix ("v" . "view")
     "p" #'ess-R-dv-pprint
     "t" #'ess-R-dv-ctable
     "s" #'ess-spreadsheet
     "~" nil
     "`" nil
     "?" nil
     "0" nil
     "1" nil
     "2" nil
     "3" nil
     "4" nil
     "5" nil
     "6" nil
     "7" nil
     "8" nil
     "9" nil
     "b" nil
     "d" nil
     "e" nil
     "i" nil
     "k" nil
     "l" nil
     "n" nil
     "o" nil
     "u" nil
     "w" nil
     "B" nil
     "K" nil
     "L" nil
     "I" nil
     "T" nil
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

   (:prefix ("d" . "dev")
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

   (:prefix ("h" . "help")
     "RET" nil
     "TAB" nil
     "<C-return>" nil
     "<down>" nil
     "<up>" nil
     "C-a" nil
     "C-d" nil
     "C-e" nil
     "C-o" nil
     "C-v" nil
     "C-w" nil
     "m" nil
     "p" nil
     "t" nil)

   (:prefix ("p" . "package-dev")
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
     "C-u" nil
     (:prefix ("c" . "check")))

   (:prefix ("x" . "extra")
     "TAB" nil
     "C-d" nil
     "C-e" nil
     "C-l" nil
     "C-r" nil
     "C-s" nil
     "C-t" nil
     "C-w" nil))

  (map!
   :map inferior-ess-r-mode-map
   :n "C-M-h" #'evil-window-left
   :n "C-M-j" #'evil-window-down
   :n "C-M-k" #'evil-window-up
   :n "C-M-l" #'evil-window-right
   :i "C-l" #'comint-clear-buffer)

  ;; ess-help-mode-map
  ;; (map!
  ;;  :localleader
  ;;  :map ess-help-mode-map)
  )

(use-package! ess-smart-equals
  :init
  (setq ess-smart-equals-extra-ops '(percent))
  :hook
  ((ess-r-mode . ess-smart-equals-mode)
   (inferior-ess-r-mode . ess-smart-equals-mode)
   (ess-r-transcript-mode . ess-smart-equals-mode)))

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
  (setq org-babel-python-command "python3"))

(use-package! crontab-mode
  :mode (("\\.cron\\(tab\\)?\\'" . crontab-mode)
         ("cron\\(tab\\)?\\." . crontab-mode)))


;;; keymap

;; global
(map!
 :nv "<C-return>" nil
 :i "C-j" nil ; for skk
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
 :desc "M-x" "SPC" #'execute-extended-command
 :desc "Project sidebar" "0" #'treemacs-select-window
 :desc "Resume last search" "."
 (cond ((featurep! :completion ivy) #'ivy-resume)
       ((featurep! :completion helm) #'helm-resume))
 :desc "Switch buffer" "," #'switch-to-buffer
 (:when (featurep! :ui workspaces)
   :desc "Switch workspace buffer" "<" #'persp-switch-to-buffer
   :desc "Switch buffer" "," #'switch-to-buffer)
 :desc "Switch to last buffer" "TAB" #'evil-switch-to-windows-last-buffer
 ;; workspace
 (:when (featurep! :ui workspaces)
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
 "`" nil)

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

;; TODO prefix key
;; emacs-lisp-mode-map
(map!
 :localleader
 :map emacs-lisp-mode-map
 :nv "e" nil
 :nv "h" #'helpful-at-point
 (:prefix-map ("e" . "eval")
   :nv "b" #'eval-buffer
   :nv "e" #'eval-last-sexp
   :nv "f" #'eval-defun
   :nv "r" #'eval-region
   :nv "x" #'lispxmp))

;; evil-org-mode-map
(map!
 :map evil-org-mode-map
 :nvi "C-j" nil)

;; org-mode-map
(map!
 :map org-mode-map
 "C-j" nil)

