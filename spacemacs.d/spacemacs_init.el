(load (expand-file-name "~/Dropbox/repos/github/five-dots/dotfiles/spacemacs.d/my-vars.el"))
(load (expand-file-name "~/Dropbox/repos/github/five-dots/dotfiles/spacemacs.d/my-secret-vars.el"))
(load (expand-file-name "~/Dropbox/repos/github/five-dots/dotfiles/spacemacs.d/my-funs.el"))

;; 1つのディレクトリにまとめて保存
;; (add-to-list 'backup-directory-alist
;;         (cons ".*" (expand-file-name "~/.emacs.d/backup")))

;; (use-package recentf-ext
;;   :config
;;   (setq recentf-max-saved-items 2000)
;;   (setq recentf-exclude '(".recentf"))
;;   (setq recentf-auto-cleanup 10)
;;   (run-with-idle-timer 30 t 'recentf-save-list)
;;   (recentf-mode 1))

(setq-default tab-width 4)

(setq vc-follow-symlinks t)

(use-package doom-themes
  :config
  ;; (doom-themes-treemacs-config)
  (doom-themes-org-config))

;; (use-package spaceline
;;   :config
;;   (spaceline-toggle-anzu-on)
;;   (spaceline-toggle-minor-modes-off)
;;   (spaceline-toggle-version-control-on)
;;   (spaceline-toggle-nyan-cat-on))

(use-package doom-modeline
  :config
  (setq doom-modeline-buffer-file-name-style 'file-name))

(use-package hide-mode-line
  :hook
  ((treemacs-mode) . hide-mode-line-mode))

(when (display-graphic-p)
  (set-frame-size (selected-frame) 140 50))

;; (setq left-fringe-width 15)

(use-package all-the-icons
  :config
  (add-to-list
   'all-the-icons-mode-icon-alist
   '(ess-r-mode all-the-icons-fileicon "R" :face all-the-icons-lblue)))

;;; fontset-default
(set-fontset-font t 'japanese-jisx0213.2004-1 (font-spec :family my-vars/fixed-jp-sans-font))
(set-fontset-font t 'katakana-jisx0201 (font-spec :family my-vars/fixed-jp-sans-font))
(my-funs/set-latin-greek-fonts t my-vars/fixed-latin-sans-font)

;;; fontset of current frame
(set-fontset-font nil 'japanese-jisx0213.2004-1 (font-spec :family my-vars/fixed-jp-sans-font))
(set-fontset-font nil 'katakana-jisx0201 (font-spec :family my-vars/fixed-latin-sans-font))
(my-funs/set-latin-greek-fonts nil my-vars/fixed-latin-sans-font)

;;; variable-pitch face
;; (create-fontset-from-ascii-font my-vars/variable-latin-sans-font nil "variable")
;; (set-fontset-font "fontset-variable" 'japanese-jisx0213.2004-1
;;                   (font-spec :family my-vars/fixed-jp-sans-font))
;; (set-fontset-font "fontset-variable" 'katakana-jisx0201
;;                   (font-spec :family my-vars/fixed-jp-sans-font))
;; (my-funs/set-latin-greek-fonts "fontset-variable" my-vars/variable-latin-sans-font)

;; (set-face-attribute 'variable-pitch nil
;;             :fontset "fontset-variable"
;;             :font "fontset-variable"
;;             :weight 'normal
;;             :slant 'normal
;;             :inherit 'default)

;;; Adjust scale
(add-to-list 'face-font-rescale-alist '(".*Meiryo*." . 1.09))
(add-to-list 'face-font-rescale-alist '(".*Yu Mincho*." . 1.09))

(use-package treemacs
  :config
  (treemacs-resize-icons 18)
  (setq treemacs-position 'right)
  (setq treemacs-lock-width t)
  (treemacs-follow-mode -1)
  (treemacs-git-mode 'simple))

(use-package highlight-indent-guides
  ;; :hook
  ;; (emacs-lisp-mode . highlight-indent-guides-mode)
  ;; (ess-r-mode      . highlight-indent-guides-mode)
  ;; (csharp-mode     . highlight-indent-guides-mode)
  :config
  ;; (setq highlight-indent-guides-responsive t)
  (setq highlight-indent-guides-method 'character))

(use-package beacon
  :diminish
  :config
  (setq beacon-blink-when-window-scrolls nil)
  (beacon-mode 1))

(use-package window-purpose
  :disabled t
  :config
  (add-to-list 'purpose-user-mode-purposes '(inferior-ess-r-mode . iess))
  (purpose-compile-user-configuration))

(use-package tabbar
  :commands tabbar-mode
  :disabled t
  :init
  (add-hook 'org-mode-hook (lambda () (tabbar-mode 1)))
  :config
  (setq tabbar-use-images nil)
  (setq tabbar-buffer-groups-function nil)
  (setq tabbar-buffer-home-button nil)
  (setq tabbar-scroll-left-button nil)
  (setq tabbar-scroll-right-button nil)
  (setq tabbar-separator '(1.5))
  ;;; Buffer list
  (setq tabbar-buffer-list-function 'my-funs/tabbar-buffer-list)
  ;;; faces
  (when window-system
    (set-face-attribute 'tabbar-default nil
                        :foreground "#bbc2cf"
                        :background "#23272e"
                        :weight 'normal
                        :slant 'normal
                        )
    (set-face-attribute 'tabbar-selected nil
                        :weight 'bold
                        )
    (set-face-attribute 'tabbar-unselected nil
                        :foreground "#5b6268"
                        )
    (set-face-attribute 'tabbar-modified nil
                        :foreground "#FD6F68"
                        :weight 'normal
                        )
    (set-face-attribute 'tabbar-selected-modified nil
                        :foreground "#FD6F68"
                        :weight 'bold
                        )
    ;; (set-face-attribute 'tabbar-button nil
    ;;                     :box nil)
    ;; (set-face-attribute 'tabbar-separator nil
    ;;                     :height 1.0)
    ))

;; (use-package iflipb
;;   :disabled t
;;   :config
;;   (setq iflipb-wrap-around t))

(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

(use-package company
  ;; :hook
  ;; ((c++-mode
  ;;   python-mode) .
  ;;   (lambda () (set (make-local-variable 'company-backends)
  ;;                   '((company-yasnippet
  ;;                      company-lsp
  ;;                      ;; company-dabbrev-code
  ;;                      company-files)))))
  :config
  (setq company-idle-delay 0)
  (setq company-echo-delay 0)
  (setq company-minimum-prefix-length 1))

(use-package company-posframe
  :disabled t
  :after (company)
  :hook (company-mode . company-posframe-mode))

(use-package company-box
  :disabled t
  :diminish
  :after (company)
  :hook (company-mode . company-box-mode)
  :init (setq company-box-icons-alist 'company-box-icons-all-the-icons)
  :config
  (setq company-box-backends-colors nil)
  (setq company-box-show-single-candidate t)
  (setq company-box-max-candidates 50)
  (defun company-box-icons--elisp (candidate)
    (when (derived-mode-p 'emacs-lisp-mode)
      (let ((sym (intern candidate)))
        (cond ((fboundp sym) 'Function)
              ((featurep sym) 'Module)
              ((facep sym) 'Color)
              ((boundp sym) 'Variable)
              ((symbolp sym) 'Text)
              (t . nil)))))
  (with-eval-after-load 'all-the-icons
    (declare-function all-the-icons-faicon 'all-the-icons)
    (declare-function all-the-icons-fileicon 'all-the-icons)
    (declare-function all-the-icons-material 'all-the-icons)
    (declare-function all-the-icons-octicon 'all-the-icons)
    (setq company-box-icons-all-the-icons
          `((Unknown . ,(all-the-icons-material "find_in_page" :height 0.7 :v-adjust -0.15))
            (Text . ,(all-the-icons-faicon "book" :height 0.68 :v-adjust -0.15))
            (Method . ,(all-the-icons-faicon "cube" :height 0.7 :v-adjust -0.05 :face 'font-lock-constant-face))
            (Function . ,(all-the-icons-faicon "cube" :height 0.7 :v-adjust -0.05 :face 'font-lock-constant-face))
            (Constructor . ,(all-the-icons-faicon "cube" :height 0.7 :v-adjust -0.05 :face 'font-lock-constant-face))
            (Field . ,(all-the-icons-faicon "tags" :height 0.65 :v-adjust -0.15 :face 'font-lock-warning-face))
            (Variable . ,(all-the-icons-faicon "tag" :height 0.7 :v-adjust -0.05 :face 'font-lock-warning-face))
            (Class . ,(all-the-icons-faicon "clone" :height 0.65 :v-adjust 0.01 :face 'font-lock-constant-face))
            (Interface . ,(all-the-icons-faicon "clone" :height 0.65 :v-adjust 0.01))
            (Module . ,(all-the-icons-octicon "package" :height 0.7 :v-adjust -0.15))
            (Property . ,(all-the-icons-octicon "package" :height 0.7 :v-adjust -0.05 :face 'font-lock-warning-face)) ;; Golang module
            (Unit . ,(all-the-icons-material "settings_system_daydream" :height 0.7 :v-adjust -0.15))
            (Value . ,(all-the-icons-material "format_align_right" :height 0.7 :v-adjust -0.15 :face 'font-lock-constant-face))
            (Enum . ,(all-the-icons-material "storage" :height 0.7 :v-adjust -0.15 :face 'all-the-icons-orange))
            (Keyword . ,(all-the-icons-material "filter_center_focus" :height 0.7 :v-adjust -0.15))
            (Snippet . ,(all-the-icons-faicon "code" :height 0.7 :v-adjust 0.02 :face 'font-lock-variable-name-face))
            (Color . ,(all-the-icons-material "palette" :height 0.7 :v-adjust -0.15))
            (File . ,(all-the-icons-faicon "file-o" :height 0.7 :v-adjust -0.05))
            (Reference . ,(all-the-icons-material "collections_bookmark" :height 0.7 :v-adjust -0.15))
            (Folder . ,(all-the-icons-octicon "file-directory" :height 0.7 :v-adjust -0.05))
            (EnumMember . ,(all-the-icons-material "format_align_right" :height 0.7 :v-adjust -0.15 :face 'all-the-icons-blueb))
            (Constant . ,(all-the-icons-faicon "tag" :height 0.7 :v-adjust -0.05))
            (Struct . ,(all-the-icons-faicon "clone" :height 0.65 :v-adjust 0.01 :face 'font-lock-constant-face))
            (Event . ,(all-the-icons-faicon "bolt" :height 0.7 :v-adjust -0.05 :face 'all-the-icons-orange))
            (Operator . ,(all-the-icons-fileicon "typedoc" :height 0.65 :v-adjust 0.05))
            (TypeParameter . ,(all-the-icons-faicon "hashtag" :height 0.65 :v-adjust 0.07 :face 'font-lock-const-face))
            (Template . ,(all-the-icons-faicon "code" :height 0.7 :v-adjust 0.02 :face 'font-lock-variable-name-face))))))

(use-package company-quickhelp
  :defines company-quickhelp-delay
  :after (company)
  :bind (:map company-active-map
              ("M-h" . company-quickhelp-manual-begin))
  :hook (global-company-mode . company-quickhelp-mode)
  :custom (company-quickhelp-delay 0.8))

;; (use-package company-dict
;;   :config
;;   (add-to-list 'company-backends 'company-dict)
;;   (setq company-dict-dir (concat user-emacs-directory "dict/")))

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
  :diminish
  :config
  (setq ivy-posframe-parameters '((left-fringe . 5) (right-fringe . 5)))
  (setq ivy-posframe-width 130)
  (setq ivy-posframe-height 10)

  ;; Per command settings
  (setq ivy-posframe-display-functions-alist
		'(
          ;; (counsel-M-x               . ivy-posframe-display-at-frame-center)
          ;; (counsel-apropos           . ivy-posframe-display-at-frame-center)
          ;; (counsel-describe-function . ivy-posframe-display-at-frame-center)
          ;; (counsel-describe-variable . ivy-posframe-display-at-frame-center)
          ;; (counsel-linux-app         . ivy-posframe-display-at-frame-center)
          ;; (counsel-recentf           . ivy-posframe-display-at-frame-center)
          ;; (counsel-find-file         . ivy-posframe-display-at-frame-center)
          ;; (package-install           . ivy-posframe-display-at-frame-center)
          ;; (ivy-switch-buffer         . ivy-posframe-display-at-frame-center)
          (swiper . nil)
		  (t . ivy-posframe-display-at-frame-center)
          ))

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

(use-package lsp)

(use-package lsp-ui
  :config
  ;; (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-doc-header nil)
  (setq lsp-ui-doc-position 'at-point)
  (setq lsp-ui-doc-use-childframe t)
  (setq lsp-ui-doc-use-webkit nil) ; なぜか動かない
  (setq lsp-ui-doc-max-height 30)
  (setq lsp-ui-doc-max-width 150)
  ;;; sideline
  ;; (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-sideline-show-symbol t)
  (setq lsp-ui-sideline-show-hover t)
  (setq lsp-ui-sideline-ignore-duplicate t)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-sideline-code-actions-prefix ""))

(use-package ess
  ;; Enable company for iESS
  :hook (inferior-ess-r-mode . company-mode)
  :config
  (use-package ess-r-mode)
  (setq ess-eldoc-show-on-symbol t)
  (setq ess-history-file nil)
  (setq ess-use-R-completion nil)
  (setq ess-use-auto-complete nil)
  (setq ess-use-ido nil)
  ;; Object popup by tooltip
  (setq ess-describe-at-point-method 'tooltip)
  (setq x-gtk-use-system-tooltips nil)
  (setq tooltip-hide-delay 60)
  (setq ess-R-describe-object-at-point-commands
        '(("str(%s)")
          (".ess_htsummary(%s, hlength = 14, tlength = 14)")
          ("summary(%s, maxsum = 20)")))
  ;; (setq ess-ask-about-transfile nil)
  ;; (setq inferior-R-args "")
  ;; (setq ess-indent-with-fancy-comments nil)
  (spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
    ;; "SPC" 'ess-view-inspect-df
    ;; "" 'ess-describe-object-at-point
    ;; "" 'ess-r-set-evaluation-env
    "h d"   nil
    "h s"   'ess-spreadsheet
    "h RET" nil
    "h TAB" nil
    )
  (spacemacs/set-leader-keys-for-major-mode 'inferior-ess-r-mode
    "v" 'ess-view-inspect-df
    "l" 'comint-clear-buffer
    "r" 'inferior-ess-reload)

  (dolist (m (list ess-r-mode-map inferior-ess-r-mode-map org-mode-map))
    (bind-keys :map m
               ("C-=" . my-funs/insert-R-assign)
               ("C->" . my-funs/insert-R-pipe))))

(use-package ess-spreadsheet
  :after (ess)
  :load-path "~/Dropbox/repos/private/elisp/ess-spreadsheet")
;; (spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
;;   "h SPC" 'ess-spreadsheet)

;; (use-package ess-view
;;   :if (eq system-type 'gnu/linux)
;;   :config
;;   (setq ess-view--spreadsheet-program "/usr/bin/gnumeric")
;;   :if (eq system-type 'windows-nt)
;;   :config
;;   (setq ess-view--spreadsheet-program
;;         "c:/Program Files (x86)/Microsoft Office/root/Office16/EXCEL.EXE"))

;; (add-to-list 'load-path "~/Dropbox/repos/github/myuhe/inlineR.el")
;; (use-package inlineR)

(use-package python
  :after (org)
  :config
  (setq python-shell-interpreter "python3")
  (add-to-list 'python-shell-completion-native-disabled-interpreters "python3")
  (setq org-babel-python-command "python3"))

(use-package jupyter
  :disabled t
  :after (org)
  :config
  ;; ;; ob-jupyter を python のデフォルトにする
  ;; (org-babel-jupyter-override-src-block "python"))
  (setq org-babel-default-header-args:jupyter-python
        '((:kernel . "python3"))))

(use-package ein
  :disabled t
  :config
  (setq ob-ein-inline-image-directory 
    (expand-file-name "~/Dropbox/memo/img/babel-ein/")))

(use-package ob-ipython
  :disabled t)

(use-package cc-mode
  :after (lsp)
  :config
  (setq c-c++-lsp-cache-dir (expand-file-name "~/.spacemacs.d/.cache/lsp-ccls")))

(use-package ccls
  :config
  (setq ccls-executable "/usr/local/bin/ccls")
  (setq ccls-sem-highlight-method 'font-lock))

(use-package crontab-mode
  :load-path "~/Dropbox/repos/private/elisp/crontab-mode"
  :mode (("\\.cron\\(tab\\)?\\'" . crontab-mode)
         ("cron\\(tab\\)?\\."    . crontab-mode)))

(use-package stan-mode
  :hook (stan-mode . company-mode)
  :config
  ;; (add-hook 'stan-mode (lambda () (setq company-backends '(company-dabbrev-code))))
  (use-package stan-snippets))

(use-package org
  :config
  ;;; Appearance
  ;; Replace "-" with "•"
  (font-lock-add-keywords
    'org-mode
    '(("^ *\\([-]\\) "
      (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (setq org-hide-emphasis-markers t)
  ;;; org faces
  (set-face-attribute 'org-level-1 nil :slant 'italic :height 1.1)
  ;; (set-face-attribute 'org-block-end-line nil :foreground "#23272e")
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
  ;; (setq org-image-actual-width nil)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (shell . t)
     (R . t)
     (C . t)
     (stan . t)
     (emacs-lisp . t)
     (python . t)
     ;; (ipython . t)
     ;; (ein . t)
     ;; (jupyter . t) ; jupyter は最後である必要あり
     ))
  ;; (org-babel-jupyter-override-src-block "python")
  ;;; Latex preview
  (setq org-preview-latex-image-directory "~/Dropbox/memo/img/latex/")
  ;; (setq org-preview-latex-default-process 'dvisvgm)
  (plist-put org-format-latex-options :scale 1.5)
  ;;; Custom function to get ramdom file name
  (cl-defun get-babel-file (&key
                             (dir (expand-file-name "~/Dropbox/memo/img/babel/"))
                             (prefix "fig-")
                             (suffix ".png"))
    (concat dir (make-temp-name prefix) suffix)))

(use-package org-download
  :config
  (setq-default org-download-image-dir (expand-file-name "~/Dropbox/memo/img/download"))
  (setq org-download-image-dir (expand-file-name "~/Dropbox/memo/img/download")))

(use-package org-bullets
  :commands (org-bullets-mode)
  :init
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  :config
  (setq org-bullets-bullet-list '("" "" "" "" "" "" "" "" "" "")))

(use-package org-variable-pitch
  :diminish
  :commands (org-variable-pitch-minor-mode)
  ;; :init
  ;; (add-hook 'org-mode-hook (lambda () (org-variable-pitch-minor-mode 1)))
  :config
  (dolist (f org-variable-pitch-fixed-faces)
    (set-face-attribute f nil :fontset "fontset-auto1" :font "fontset-auto1")))

;; (use-package org-babel-eval-in-repl
;;   :init
;;   (bind-keys :map org-mode-map ("C-<return>" . ober-eval-in-repl)))



(use-package paradox
  :config
  (setq paradox-github-token my-vars/paradox-github-token))

;; (use-package zeal-at-point
;;   :config
;;   (add-to-list 'zeal-at-point-mode-alist '(ess-r-mode . "r")))

(use-package evil-vimish-fold
  :diminish
  :config
  (setq vimish-fold-dir (expand-file-name "~/Dropbox/cache/spacemacs/vimish-fold/"))
  (evil-vimish-fold-mode 1))

(use-package page-break-lines
  :config
  (add-to-list 'page-break-lines-modes 'ess-r-mode)
  (add-to-list 'page-break-lines-modes 'python-mode)
  (global-page-break-lines-mode))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

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

;; (use-package mozc-im
;;   :config
;;   (setq default-input-method "japanese-mozc-im"))

;; (use-package mozc-popup
;;   :config
;;   (setq mozc-candidate-style 'popup))

(use-package mozc-mode-line-indicator
  :load-path "~/Dropbox/repos/github/iRi-E/mozc-el-extensions")

(use-package mozc-isearch
  :load-path "~/Dropbox/repos/github/iRi-E/mozc-el-extensions")

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
              ))

(bind-keys :map evil-insert-state-map
        ("C-," . company-manual-begin))

(spacemacs/set-leader-keys
  ","   'ivy-switch-buffer
  "."   'ivy-resume
  ;; ","   'tabbar-backward-tab
  ;; "."   'tabbar-forward-tab
  "a l" 'counsel-linux-app
  "w w" 'ace-window
  "w W" 'other-window)

(spacemacs/set-leader-keys-for-major-mode 'emacs-lisp-mode
  "e x" 'lispxmp)

(spacemacs/set-leader-keys-for-major-mode 'lisp-interaction-mode
  "e x" 'lispxmp)
