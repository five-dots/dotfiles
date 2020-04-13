
;;; Load private libraries
(load (expand-file-name "funcs" my/elisp-dir))


;;; misc

(when my/mac-p ; Use osx command as meta
  (setq mac-command-modifier 'meta))

(use-package vc
  :config
  (setq vc-follow-symlinks t))

(use-package recentf
  :config
  ;; recentf per host
  (setq recentf-save-file
        (concat spacemacs-cache-directory "recentf/" system-name))
  ;; (setq recentf-auto-cleanup 60)
  (setq recentf-max-saved-items 1000)
  (setq recentf-exclude '(".recentf")))

(use-package saveplace
  :config
  (setq save-place-file
        (concat spacemacs-cache-directory "saveplace/" system-name)))

(use-package projectile
  :config
  (setq projectile-known-projects-file
        (concat spacemacs-cache-directory "projectile-bookmarks/" system-name ".eld")))

(use-package google-translate
  :config
  (setq google-translate-pop-up-buffer-set-focus t)
  (setq google-translate-default-source-language "en")
  (setq google-translate-default-target-language "ja"))


;;; evil

(use-package evil
  :config
  (evil-define-key '(normal visual) 'global
    (kbd "<next>") 'evil-forward-paragraph
    (kbd "<prior>") 'evil-backward-paragraph
    "j" 'evil-next-visual-line
    "k" 'evil-previous-visual-line
    "gj" 'evil-next-line
    "gk" 'evil-previous-line)
  ;; TODO do not use C-M
  ;; (evil-define-key '(normal) 'global
  ;;  (kbd "C-M-h") 'evil-window-left
  ;;  (kbd "C-M-j") 'evil-window-down
  ;;  (kbd "C-M-k") 'evil-window-up
  ;;  (kbd "C-M-l") 'evil-window-right)
  )


;;; completion

(use-package company
  :bind
  (:map company-active-map
        ("M-." . company-filter-candidates)
        ("M-/" . company-search-candidates)
        ("M-d" . company-next-page)
        ("M-i" . company-show-doc-buffer)
        ;; TODO change quickhelp font for osx
        ("M-p" . company-quickhelp-manual-begin)
        ("M-u" . company-previous-page)
        ("M-w" . company-show-location))
  :config
  (setq completion-ignore-case t)
  (setq read-file-name-completion-ignore-case t)
  (setq read-buffer-completion-ignore-case t)
  ;; TODO explore lighten company setting
  ;; Delay
  (setq company-idle-delay 0.1)
  ;; (setq company-idle-delay 1)
  (setq company-minimum-prefix-length 2)
  (evil-define-key 'insert 'global
    (kbd "M-,") 'company-manual-begin))

(use-package company-statistics
  :config
  (setq company-statistics-file
        (concat spacemacs-cache-directory "company-statistics-cache/" system-name ".el")))

(use-package counsel
  :config
  ;; TODO align separator length with ivy-posframe length
  (setq counsel-yank-pop-separator
        "\n------------------------------\n")
  (add-to-list 'ivy-height-alist
               '(counsel-yank-pop . 15)))


;;; ui
(use-package doom-themes
  :config
  (doom-themes-org-config))

(use-package treemacs
  ;; TODO do not use C-M
  :bind
  (:map treemacs-mode-map
        ("C-M-h" . evil-window-left)
        ("C-M-j" . evil-window-down)
        ("C-M-k" . evil-window-up)
        ("C-M-l" . evil-window-right))
  :init
  (setq treemacs-use-follow-mode nil)
  :config
  (setq treemacs-persist-file
        (concat user-emacs-directory ".cache/treemacs-persist/" system-name))
  (setq treemacs-position 'right)
  (setq treemacs-lock-width t)
  (treemacs-resize-icons 18))

(when (display-graphic-p) ; frame size
  (set-frame-size (selected-frame) 120 50))

(when (display-graphic-p) ; font
  ;; |abcdef ghijkl|
  ;; |ABCDEF GHIJKL|
  ;; |'";:-+ =/\~`?|
  ;; |∞≤≥∏∑∫ ×±⊆⊇|
  ;; |αβγδεζ ηθικλμ|
  ;; |ΑΒΓΔΕΖ ΗΘΙΚΛΜ|
  ;; |abcdef ghijkl|
  ;; |ABCDEF GHIJKL|
  ;; |日本語 の美観|
  ;; |あいう えおか|
  ;; |アイウ エオカ|
  ;; |ｱｲｳｴｵｶ ｷｸｹｺｻｼ|
  (set-fontset-font t 'japanese-jisx0213.2004-1 (font-spec :family my/fixed-jp-sans-font))
  (set-fontset-font t 'katakana-jisx0201 (font-spec :family my/fixed-jp-sans-font))
  (my/set-latin-greek-fonts t my/fixed-latin-sans-font)
  ;;; fontset of current frame
  ;; (set-fontset-font nil 'japanese-jisx0213.2004-1 (font-spec :family my/fixed-jp-sans-font))
  ;; (set-fontset-font nil 'katakana-jisx0201 (font-spec :family my/fixed-jp-sans-font))
  ;; (my/set-latin-greek-fonts nil my/fixed-latin-sans-font)
  ;;; variable-pitch face
  ;; (create-fontset-from-ascii-font my/variable-latin-sans-font nil "variable")
  ;; (set-fontset-font "fontset-variable" 'japanese-jisx0213.2004-1
  ;;                   (font-spec :family my/fixed-jp-sans-font))
  ;; (set-fontset-font "fontset-variable" 'katakana-jisx0201
  ;;                   (font-spec :family my/fixed-jp-sans-font))
  ;; (my/set-latin-greek-fonts "fontset-variable" my/variable-latin-sans-font)
  ;; (set-face-attribute 'variable-pitch nil
  ;;             :fontset "fontset-variable"
  ;;             :font "fontset-variable"
  ;;             :weight 'normal
  ;;             :slant 'normal
  ;;             :inherit 'default)
  ;;; Adjust scale
  ;; (add-to-list 'face-font-rescale-alist '(".*Yu Mincho*." . 1.09))
  (add-to-list 'face-font-rescale-alist '(".*Meiryo*." . 1.09)))

(use-package all-the-icons
  :config
  (add-to-list
   'all-the-icons-mode-icon-alist
   '(inferior-ess-r-mode all-the-icons-fileicon "R" :face all-the-icons-lblue)))

(use-package page-break-lines
  :config
  (add-to-list 'page-break-lines-modes 'ess-r-mode)
  (add-to-list 'page-break-lines-modes 'python-mode)
  (add-to-list 'page-break-lines-modes 'shell-script-mode)
  (global-page-break-lines-mode))


;;; org

(use-package org
  :hook
  (org-mode . visual-line-mode)
  ;; :init
  ;; FIXME
  ;; (add-hook 'org-mode-hook 'my/set-company-backend-for-org)

  :config
  ;; Appearance
  ;; Replace "-" with "•"
  (font-lock-add-keywords
    'org-mode
    '(("^ *\\([-]\\) "
      (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (setq org-hide-emphasis-markers t)
  ;; org faces
  (set-face-attribute 'org-level-1 nil :slant 'italic :height 1.0)
  ;; (set-face-attribute 'org-block-end-line nil :foreground "#23272e")

  ;; org-agenda
  ;; Add agenda file recursively
  ;; https://www.reddit.com/r/orgmode/comments/6q6cdk/adding_files_to_the_agenda_list_recursively/
  ;; (setq org-agenda-files
  ;; (apply 'append
  ;;         (mapcar (lambda (directory)
  ;;       (directory-files-recursively directory org-agenda-file-regexp))
  ;;           '("~/Dropbox/memo"))))
  ;; agenda format
  ;; Aligned Agenda View. Anyway to make this more clean? IE, having the TODO Keywords all line up?
  ;; https://www.reddit.com/r/orgmode/comments/6ybjjw/aligned_agenda_view_anyway_to_make_this_more/
  ;; (setq org-agenda-prefix-format
  ;;       (quote
  ;;        ((agenda . " %i %-12:c%?12t% s")
  ;;         (todo   . " %i %-12:c")
  ;;         (tags   . " %i %-12:c")
  ;;         (search . " %i %-12:c"))))

  ;; org-babel
  (setq org-confirm-babel-evaluate nil)
  (setq org-src-preserve-indentation t)
  ;; (setq org-src-tab-acts-natively t)
  ;; (setq org-image-actual-width nil)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell . t)
     (R . t)
     (stan . t)
     (C . t)
     (python . t)))
  ;; (org-babel-jupyter-override-src-block "python")

  ;; Latex preview
  (setq org-preview-latex-image-directory "~/Dropbox/memo/img/latex/")
  ;; (setq org-preview-latex-default-process 'dvisvgm)
  (plist-put org-format-latex-options :scale 1.5)

  ;; exporter
  (add-to-list 'org-export-filter-latex-fragment-functions 'my/org-replace-latex-wrap))

(use-package org-download
  :config
  (setq org-download-image-dir (expand-file-name "~/Dropbox/memo/img/download")))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :config
  ;; TODO bullet for SF Mono Squre
  (setq org-bullets-bullet-list '("" "" "" "" "" "" "" "" "" "")))

(progn ; org-variable-pitch
  ;; (use-package org-variable-pitch
  ;;   :diminish
  ;;   :commands (org-variable-pitch-minor-mode)
  ;;   ;; :init
  ;;   ;; (add-hook 'org-mode-hook (lambda () (org-variable-pitch-minor-mode 1)))
  ;;   :config
  ;;   (dolist (f org-variable-pitch-fixed-faces)
  ;;     (set-face-attribute f nil :fontset "fontset-auto1" :font "fontset-auto1")))
  )

(progn ; org-babel-eval-in-repl
  ;; (use-package org-babel-eval-in-repl
  ;;   :init
  ;;   (bind-keys :map org-mode-map ("C-<return>" . ober-eval-in-repl)))
  )

(progn ; org-qiita
  ;; (use-package org-qiita
  ;;   ;; emacs の org-mode で書いた記事を qiita に投稿する org-qiita.el
  ;;   ;; https://qiita.com/dwarfJP/items/594a8d4b0ac6d248d1e4
  ;;   ;; Private Layer 側で github からインストールすると以下のエラーが発生
  ;;   ;; Error getting PACKAGE-DESC: (error Package lacks a file header)
  ;;   :load-path "~/Dropbox/repos/github/ifritJP/org-qiita-el"
  ;;   :config
  ;;   (setq org-qiita-token my/qiita-token)
  ;;   (setq org-qiita-export-and-post nil))
  )

(use-package ox-hugo
  :config
  (setq org-hugo-section "post")
  (setq org-hugo-front-matter-format "toml") ; toml or yaml
  (setq org-hugo-use-code-for-kbd t))


;;; lang

(progn ; company backend for elisp
  ;; (add-hook 'emacs-lisp-mode-hook 'my/set-company-backend-for-el)
  )

(use-package python
  :config
  (setq python-shell-interpreter "ipython3") ; "python3" or "ipython3"
  (setq org-babel-python-command "python3")
  ;; (add-to-list 'python-shell-completion-native-disabled-interpreters "python3")

  ;; https://github.com/jorgenschaefer/elpy/issues/733
  ;; (setq python-shell-prompt-detect-enabled nil)
  ;; (setq python-shell-prompt-detect-failure-warning nil)

  ;; Can’t guess python-indent-offset, using defaults: 4... のメッセージを表示しない
  (setq python-indent-guess-indent-offset-verbose nil))

(use-package comint
  :bind
  (:map comint-mode-map
        ("C-M-h" . evil-window-left)
        ("C-M-j" . evil-window-down)
        ("C-M-k" . evil-window-up)
        ("C-M-l" . evil-window-right)
        ("C-l"   . comint-clear-buffer)))

(use-package stan-mode
  :load-path "~/Dropbox/repos/github/kaz-yos/stan-mode/stan-mode"
  :mode ("\\.stan\\'" . stan-mode)
  :hook (stan-mode . stan-mode-setup)
  :init
  ;; company
  (use-package company-stan
    :load-path "~/Dropbox/repos/github/kaz-yos/stan-mode/company-stan"
    :config
    (setq company-stan-fuzzy nil))
  (add-hook 'stan-mode-hook 'my/set-company-backend-for-stan)
  ;; eldoc
  ;; FIXME
  ;; File mode specification error:
  ;; (file-missing Cannot open load file No such file or directory c-eldoc)
  ;; (use-package eldoc-stan
  ;;   :load-path "~/Dropbox/repos/github/kaz-yos/stan-mode/eldoc-stan"
  ;;   :hook (stan-mode . eldoc-stan-setup))
  :config
  (setq stan-indentation-offset 2)
  ;; Add snippets dir
  (add-to-list
   'yas-snippet-dirs
   (expand-file-name
    "~/Dropbox/repos/github/kaz-yos/stan-mode/stan-snippets/snippets")))

(use-package lsp-mode
  ;; :init
  ;; (add-hook 'lsp-mode-hook 'my/set-company-backend-for-lsp)
  :config
  ;; (setq lsp-document-sync-method 'incremental)
  ;; (setq lsp-enable-completion-at-point nil)
  ;; (setq lsp-prefer-flymake nil) ; flymake or lsp-ui
  (setq lsp-session-file (expand-file-name ".cache/lsp-session" user-emacs-directory)))

(use-package lsp-ui
  :config
  ;; (defun my/toggle-lsp-ui-doc ()
  ;;   (interactive)
  ;;   (if lsp-ui-doc-mode
  ;;       (progn
  ;;         (lsp-ui-doc-mode -1)
  ;;         (lsp-ui-doc--hide-frame))
	;;     (lsp-ui-doc-mode 1)))
  ;;; lsp-ui-doc
  (setq lsp-ui-doc-enable nil)
  ;; (setq lsp-ui-doc-header nil)
  ;; (setq lsp-ui-doc-include-signature nil)
  ;; (setq lsp-ui-doc-position 'at-point)
  ;; (setq lsp-ui-doc-max-width 150)
  ;; (setq lsp-ui-doc-max-height 30)
  ;; (setq lsp-ui-doc-use-childframe t)
  ;; (setq lsp-ui-doc-use-webkit nil)
  ;;; lsp-ui-flycheck
  ;; (setq lsp-ui-flycheck-enable t)
  ;;; lsp-ui-peek
  ;; (setq lsp-ui-peek-enable t)
  ;; (setq lsp-ui-peek-peek-height 20)
  ;; (setq lsp-ui-peek-list-width 50)
  ;; (setq lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always
  ;;; lsp-ui-imenu
  ;; (setq lsp-ui-imenu-enable nil)
  ;; (setq lsp-ui-imenu-kind-position 'top)
  ;;; lsp-ui-sideline
  ;; (setq lsp-ui-sideline-enable nil)
  ;; (setq lsp-ui-sideline-enable nil)
  ;; (setq lsp-ui-sideline-ignore-duplicate t) ; nil
  ;; (setq lsp-ui-sideline-show-symbol t)
  ;; (setq lsp-ui-sideline-show-hover t) ; nil
  ;; (setq lsp-ui-sideline-show-diagnostics nil) ; t
  ;; (setq lsp-ui-sideline-show-code-actions nil) ;t
  ;; (setq lsp-ui-sideline-code-actions-prefix "")
  )

;; (use-package lsp-python-ms
;;   :config
;;   (setq lsp-python-ms-python-executable-cmd "python3"))

;; (use-package company-lsp
;;   :config
;;   (setq company-lsp-cache-candidates t)
;;   (setq company-lsp-enable-recompletion nil))

(use-package dap-mode
  ;; TODO dap-ui-mode debug 実行時のウィンドウレイアウト
  ;; TODO hydra map を自動で表示したい
  :hook (dap-mode . my/change-fringe-width)
  :init
  :config
  (setq dap-breakpoints-file
        (expand-file-name ".cache/dap-breakpoints" user-emacs-directory))
  (use-package dap-python
    :config
    (setq dap-python-executable "python3"))
  (use-package dap-gdb-lldb))

(use-package flycheck
  :hook
  (ess-r-mode . flycheck-mode)
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabed))
  (setq flycheck-lintr-linters
        "with_defaults(
           line_length_linter(length = 80L),
           implicit_integer_linter,
           T_and_F_symbol_linter,
           todo_comment_linter,
           object_name_linter = NULL,
           cyclocomp_linter = NULL,
           pipe_continuation_linter = NULL,
           commented_code_linter = NULL
        )"))


;;; leader map

(spacemacs/set-leader-keys
  "," 'ivy-switch-buffer
  "." 'ivy-resume
  ;; applications
  "a l" 'counsel-linux-app
  ;; windows
  "w/" 'split-window-right-and-focus
  "wv" 'split-window-right-and-focus
  "wV" 'split-window-right
  "w-" 'split-window-below-and-focus
  "ws" 'split-window-below-and-focus
  "wS" 'split-window-below
  "ww" 'ace-window
  "wW" 'other-window)
