(load "~/.spacemacs.d/private/elisp/my-vars.el")
(load "~/.spacemacs.d/private/elisp/my-funs.el")

;; 1つのディレクトリにまとめて保存
;; (add-to-list 'backup-directory-alist
;;         (cons ".*" (expand-file-name "~/.emacs.d/backup")))

(use-package recentf-ext
  :config
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (run-with-idle-timer 30 t 'recentf-save-list)
  (recentf-mode 1))

(setq-default tab-width 4)

(setq vc-follow-symlinks t)

(use-package doom-themes
  :config
  ;; (doom-themes-treemacs-config)
  (doom-themes-org-config))

(when (display-graphic-p)
  (set-frame-size (selected-frame) 140 50))

;;; Fixed pitch font
;; Japanese fonts
(set-fontset-font nil 'japanese-jisx0213.2004-1 (font-spec :family my-vars/jp-font-family))
(set-fontset-font nil 'katakana-jisx0201 (font-spec :family my-vars/jp-font-family))

;; Overwrite latin and greek char's font
(set-fontset-font nil '(#x0250 . #x02AF) (font-spec :family my-vars/default-font-family))
(set-fontset-font nil '(#x00A0 . #x00FF) (font-spec :family my-vars/default-font-family))
(set-fontset-font nil '(#x0100 . #x017F) (font-spec :family my-vars/default-font-family))
(set-fontset-font nil '(#x0180 . #x024F) (font-spec :family my-vars/default-font-family))
(set-fontset-font nil '(#x2018 . #x2019) (font-spec :family my-vars/default-font-family))
(set-fontset-font nil '(#x2588 . #x2588) (font-spec :family my-vars/default-font-family))
(set-fontset-font nil '(#x2500 . #x2500) (font-spec :family my-vars/default-font-family))
(set-fontset-font nil '(#x2504 . #x257F) (font-spec :family my-vars/default-font-family))
(set-fontset-font nil '(#x0370 . #x03FF) (font-spec :family my-vars/default-font-family))

;;; Variable pitch font
(create-fontset-from-ascii-font my-vars/default-propotional-font-family nil "variable")
(set-fontset-font "fontset-variable" 'japanese-jisx0213.2004-1
        (font-spec :family my-vars/jp-propotional-font-family))
(set-fontset-font "fontset-variable" 'katakana-jisx0201
                  (font-spec :family my-vars/jp-propotional-font-family))
(set-face-attribute 'variable-pitch nil
            :fontset "fontset-variable"
            :inherit 'default)

;;; Adjust scale
(add-to-list 'face-font-rescale-alist '(".*Meiryo*." . 1.09))
(add-to-list 'face-font-rescale-alist '(".*Yu Mincho*." . 1.09))

(use-package treemacs
  :config
  (setq treemacs-position 'right))

(use-package highlight-indent-guides
  :hook
  ;; (emacs-lisp-mode . highlight-indent-guides-mode)
  (ess-r-mode      . highlight-indent-guides-mode)
  (csharp-mode     . highlight-indent-guides-mode)
  :config
  ;; (setq highlight-indent-guides-responsive t)
  (setq highlight-indent-guides-method 'character))

(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

(use-package ivy-rich
  :config
  ;; ivy-posframe-width 130
  (setq
   ivy-rich-display-transformers-list
   '(
     ivy-switch-buffer
     (:columns
      (
       ;; (my-funs/ivy-rich-buffer-icon (:width 5))
       (ivy-rich-candidate (:width 30))
       (ivy-rich-switch-buffer-size (:width 7 :align right))
       (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
       (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
       (ivy-rich-switch-buffer-project (:width 15 :face success))
       (ivy-rich-switch-buffer-path (:width 57)))
      :predicate
      (lambda (cand) (get-buffer cand)))

     counsel-M-x
     (:columns
      ((counsel-M-x-transformer (:width 40))
       (ivy-rich-counsel-function-docstring (:width 89 :face font-lock-doc-face))))

     counsel-describe-function
     (:columns
      ((counsel-describe-function-transformer (:width 40))
       (ivy-rich-counsel-function-docstring (:width 89 :face font-lock-doc-face))))

     counsel-describe-variable
     (:columns
      ((counsel-describe-variable-transformer (:width 40))
       (ivy-rich-counsel-variable-docstring (:width 89 :face font-lock-doc-face))))

     counsel-find-file
     (:columns
      ((ivy-read-file-transformer)
       (ivy-rich-counsel-find-file-truename (:face font-lock-doc-face))))

     counsel-recentf
     (:columns
      (
       ;; (my-funs/ivy-rich-file-icon (:width 5))
	   (ivy-rich-candidate (:width 110))
       (ivy-rich-file-last-modified-time (:width 19 :face font-lock-comment-face))))

     package-install
     (:columns
      ((ivy-rich-candidate (:width 30))
       (ivy-rich-package-version (:width 16 :face font-lock-comment-face))
       (ivy-rich-package-archive-summary (:width 7 :face font-lock-builtin-face))
       (ivy-rich-package-install-summary (:width 74 :face font-lock-doc-face))))
     ))
  ;; Restart ivy-rich-mode
  (ivy-rich-mode -1)
  (ivy-rich-mode))

(use-package ivy-posframe
  :config
  (setq ivy-posframe-parameters '((left-fringe . 5) (right-fringe . 5)))
  (setq ivy-posframe-width 130)
  (setq ivy-posframe-height 10)

  ;; Per command settings
  (setq ivy-posframe-display-functions-alist
		'((swiper . nil)
		  (t      . ivy-posframe-display-at-frame-center)))

  ;; Per command height settings
  (setq ivy-posframe-height-alist
				'((swiper . 20)
				  (t      . 10)))

  (ivy-posframe-mode)
  :custom-face
  ;; See ivy-posframe-parameters
  (ivy-posframe ((t (:background "#282a36"))))
  (ivy-posframe-border ((t (:background "#6272a4"))))
  (ivy-posframe-cursor ((t (:background "#61bfff")))))

(use-package org
  :config
  ;;; Appearance
  ;; Replace "-" with "•"
  (font-lock-add-keywords
    'org-mode
    '(("^ *\\([-]\\) "
      (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (setq org-hide-emphasis-markers t)
  ;;; org-agenda
  ;; Add agenda file recursively
  (setq org-agenda-files
  (apply 'append
          (mapcar (lambda (directory)
        (directory-files-recursively directory org-agenda-file-regexp))
            '("~/Dropbox/memo"))))
  ;; agenda format
  ;; (setq org-agenda-prefix-format
  ;;       (quote
  ;;        ((agenda . " %i %-12:c%?12t% s")
  ;;         (todo   . " %i %-12:c")
  ;;         (tags   . " %i %-12:c")
  ;;         (search . " %i %-12:c"))))
  ;;; org-babel
  (setq org-confirm-babel-evaluate nil)
  (setq org-src-preserve-indentation t)
  (setq org-src-tab-acts-natively nil)
  ;;; Latex preview
  (setq org-preview-latex-image-directory "~/Dropbox/memo/img/latex/")
  ;; (setq org-preview-latex-default-process 'dvisvgm)
  (plist-put org-format-latex-options :scale 1.5)
  ;;; Custom function to get ramdom file name
  (cl-defun get-babel-file (&key
                            (dir "~/Dropbox/memo/img/babel/")
                            (prefix "fig-")
                            (suffix ".png"))
    (concat dir (make-temp-name prefix) suffix)))

;; Change font size by levels
;; (custom-set-faces
;;  '(org-level-1 ((t (:inherit outline-1 :height 1.35))))
;;  '(org-level-2 ((t (:inherit outline-2 :height 1.3))))
;;  '(org-level-3 ((t (:inherit outline-3 :height 1.25))))
;;  '(org-level-4 ((t (:inherit outline-4 :height 1.0)))))

(use-package org-bullets
  :commands (org-bullets-mode)
  :init
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  :config
  (setq org-bullets-bullet-list '("" "" "" "" "" "" "" "" "")))

;; (use-package org-babel-eval-in-repl
;;   :init
;;   (bind-keys :map org-mode-map ("C-<return>" . ober-eval-in-repl)))

;; (add-hook 'org-mode-hook 'org-variable-pitch-minor-mode)
;; (require 'org-variable-pitch)

;; (defun set-buffer-variable-pitch ()
;;   (interactive)
;;   (variable-pitch-mode t)
;;   (setq line-spacing 3)
;;   (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
;;   (set-face-attribute 'org-link nil :inherit 'fixed-pitch)
;;   (set-face-attribute 'org-code nil :inherit 'fixed-pitch)
;;   (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
;;   (set-face-attribute 'org-date nil :inherit 'fixed-pitch)
;;   (set-face-attribute 'org-special-keyword nil :inherit 'fixed-pitch))

;; (add-hook 'org-mode-hook 'set-buffer-variable-pitch)
;; (add-hook 'markdown-mode-hook 'set-buffer-variable-pitch)
;; (add-hook 'Info-mode-hook 'set-buffer-variable-pitch)

(use-package ess
  ;; Enable company for iESS
  ;; :hook
  ;; (inferior-ess-r-mode . company-mode)
  :config
  (use-package ess-r-mode)
  (setq ess-eldoc-show-on-symbol t)
  (setq ess-history-file nil)
  (setq ess-use-R-completion nil)
  (setq ess-use-auto-complete nil)
  (setq ess-use-ido nil)
  ;; (setq ess-ask-about-transfile nil)
  ;; (setq ess-ask-for-ess-directory nil)
  ;; (setq inferior-R-args "")
  ;; (setq ess-indent-with-fancy-comments nil)

  ;;; ess-R-object-popup
  (add-to-list 'load-path "~/Dropbox/repos/github/myuhe/ess-R-object-popup.el")
  (use-package ess-R-object-popup)

  ;; ESS
  (spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
    ;; "SPC" 'ess-view-inspect-df
    ;; "" 'ess-describe-object-at-point
    ;; "" 'ess-r-set-evaluation-env
    "."   'ess-R-object-popup)
  (spacemacs/set-leader-keys-for-major-mode 'inferior-ess-r-mode
    "v" 'ess-view-inspect-df
    "l" 'comint-clear-buffer
    "r" 'inferior-ess-reload)

  (dolist (m (list ess-r-mode-map inferior-ess-r-mode-map org-mode-map))
    (bind-keys :map m
               ("C-=" . my-funs/insert-R-assign)
               ("C->" . my-funs/insert-R-pipe))))

(use-package ess-view
  :if (eq system-type 'gnu/linux)
  :config
  (setq ess-view--spreadsheet-program "/usr/bin/gnumeric")
  :if (eq system-type 'windows-nt)
  :config
  (setq ess-view--spreadsheet-program
        "c:/Program Files (x86)/Microsoft Office/root/Office16/EXCEL.EXE"))

(add-to-list 'load-path "~/Dropbox/repos/private/elisp/ess-spreadsheet")
(require 'ess-spreadsheet)

;; (spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
;;   "h SPC" 'ess-spreadsheet)

(add-to-list 'load-path "~/Dropbox/repos/github/myuhe/inlineR.el")
(use-package inlineR)

(use-package paradox
  :config
  (setq paradox-github-token "144882f652e8d571fa68755827e29defe71d7b21"))

(use-package mozc
  :config
  (setq default-input-method "japanese-mozc")
  (setq mozc-candidate-style 'echo-area)

  (bind-keys :map evil-insert-state-map
             ([muhenkan] . my-funs/toggle-ime)
             ([henkan]   . my-funs/deactivate-ime))
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
  (add-hook 'evil-insert-state-exit-hook 'my-funs/deactivate-ime))

(use-package mozc-im
  :disabled t
  :config
  (setq default-input-method "japanese-mozc-im"))

(use-package mozc-popup
  :disabled t
  :config
  (setq mozc-candidate-style 'popup))

(add-to-list 'load-path "~/Dropbox/repos/github/iRi-E/mozc-el-extensions")
(require 'mozc-mode-line-indicator)
(require 'mozc-isearch)
;; (require 'mozc-cursor-color)

;; (add-to-list 'load-path "~/Dropbox/repos/github/derui/mozc-posframe")
;; (require 'mozc-posframe)
;; (setq mozc-candidate-style 'posframe)

(use-package migemo
  :if (eq system-type 'gnu/linux)
  :config
  (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
  :if (eq system-type 'windows-nt)
  :config
  (setq migemo-dictionary "C:/Users/shun/AppData/Local/cmigemo-default-win64/dict/utf-8/migemo-dict"))

(use-package skk
  :disabled t
  :defer t
  :init (setq skk-tut-file "~/Dropbox/skk/SKK.tut")
  :config
  ;; (setq default-input-method "japanese-skk")
  ;; Henkan candidates
  (setq skk-show-inline t)
  ;; Cursor color
  (setq skk-use-color-cursor t)
  (setq skk-cursor-hiragana-color "yellow")
  (setq skk-cursor-katakana-color "blue violet")
  ;; Personal jisyo
  (setq skk-jisyo "~/Dropbox/skk/jisyo/skk-jisyo")
  (setq skk-backup-jisyo "~/Dropbox/skk/jisyo/skk-jisyo.bak")
  ;; Record file
  (setq skk-record-file "~/Dropbox/skk/record")
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
  ;; Enable latin mode at startup
  ;; http://slackwareirregulars.blogspot.com/2018/03/skk.html
  (let ((function #'(lambda () (skk-mode) (skk-latin-mode-on))))
    (dolist (hook '(org-mode-hook
                    find-file-hooks
                    minibuffer-setup-hook
                    mail-setup-hook
                    message-setup-hook))
      (add-hook hook function)))
  ;; Switch to latin mode when entering normal state
  ;; https://github.com/zarudama/dotfiles/blob/master/emacs/mikio/mikio-evil.el
  (defun my-skk-control ()
    (when skk-mode
      (skk-latin-mode 1)))
  (add-hook 'evil-normal-state-entry-hook 'my-skk-control))

(use-package google-translate
  :config (setq google-translate-default-target-language "ja"))

(dolist (m (list evil-normal-state-map evil-visual-state-map))
  (bind-keys :map m
              ("H"  . evil-first-non-blank-of-visual-line)
              ("J"  . evil-forward-paragraph)
              ("K"  . evil-backward-paragraph)
              ("L"  . evil-end-of-visual-line)
              ("j"  . evil-next-visual-line)
              ("k"  . evil-previous-visual-line)
              ("gj" . evil-next-line)
              ("gk" . evil-previous-line)
              ("C-M-h" . evil-window-left)
              ("C-M-j" . evil-window-down)
              ("C-M-k" . evil-window-up)
              ("C-M-l" . evil-window-right)
              ))

(bind-keys :map evil-insert-state-map
        ("C-," . company-manual-begin))

(spacemacs/set-leader-keys
  ","   'ivy-switch-buffer
  "."   'ivy-resume
  "a l" 'counsel-linux-app)

(spacemacs/set-leader-keys-for-major-mode 'emacs-lisp-mode
  "e x" 'lispxmp)

(spacemacs/set-leader-keys-for-major-mode 'lisp-interaction-mode
  "e x" 'lispxmp)
