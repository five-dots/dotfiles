;;; core

(progn
  (setq user-full-name "Shun Asai")
  (setq user-mail-address "syun.asai@gmail.com")

  ;; Load private libraries
  (load (expand-file-name "funcs.el" my/elisp-dir)))


;;; completion

(use-package company
  :defer t

  :config
  ;; ignore case
  (setq completion-ignore-case t)
  (setq read-file-name-completion-ignore-case t)
  (setq read-buffer-completion-ignore-case t)

  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 2)
  (setq company-show-numbers nil)
  (setq company-tooltip-align-annotations t)

  (setq company-global-modes
        '(not erc-mode message-mode help-mode helpful-mode
              gud-mode eshell-mode shell-mode))

  ;; frontends
  (setq
   company-frontends
   '(
     ;; company-pseudo-tooltip-unless-just-one-frontend ; default enabled
     company-pseudo-tooltip-frontend
     ;; company-preview-if-just-one-frontend ; default enabled
     company-echo-metadata-frontend ; default enabled
     ))

  (bind-keys
   :map company-active-map
   ("H-SPC" . company-complete-common)
   ("<tab>" . company-complete-selection)
   ("H-;" . company-complete-selection)
   ("H-." . company-filter-candidates)
   ("H-/" . company-search-candidates)
   ("H-d" . company-next-page)
   ("H-u" . company-previous-page)
   ("H-i" . company-show-doc-buffer)
   ("H-p" . company-quickhelp-manual-begin)
   ("H-w" . company-show-location)
   ("H-c" . counsel-company))

  (evil-define-key 'insert 'global
    (kbd "H-,") 'company-manual-begin))

(use-package ivy
  :config
  (setq ivy-height 10))

(use-package counsel
  :config
  (setq counsel-yank-pop-separator
        "\n--------------------------------------------------------------------------------------------------------------\n"))


;;; ui

(use-package doom-themes
  :config
  (doom-themes-org-config))

(use-package treemacs
  :defer t

  :init
  (setq treemacs-use-follow-mode nil)

  :config
  (setq treemacs-position 'right)
  (setq treemacs-lock-width t)
  (treemacs-resize-icons 16))

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
  ;; https://github.com/domtronn/all-the-icons.el
  ;; (insert (all-the-icons-icon-for-buffer))
  ;; (insert (all-the-icons-icon-for-dir "~/"))
  ;; (insert (all-the-icons-icon-for-file "foo.R"))
  ;; (insert (all-the-icons-icon-for-mode 'emacs-lisp-mode))
  ;; (insert (all-the-icons-icon-for-url "https://google.com"))

  ;; see below list for more details
  ;; all-the-icons-data/octicons-alist
  ;; all-the-icons-data/alltheicons-alist
  ;; all-the-icons-data/fa-icon-alist
  ;; all-the-icons-data/material-icons-alist
  ;; all-the-icons-data/material-icons-alist

  :config
  ;; file icons
  (add-to-list
   'all-the-icons-icon-alist
   '("\\.desktop$" all-the-icons-faicon "desktop"
     :height 1.0 :v-adjust 0.0 :face all-the-icons-blue))

  ;; mode icons
  (add-to-list
   'all-the-icons-mode-icon-alist
   '(inferior-ess-r-mode all-the-icons-fileicon "R" :face all-the-icons-lblue)))

(use-package page-break-lines
  :config
  (add-to-list 'page-break-lines-modes 'ess-r-mode)
  (add-to-list 'page-break-lines-modes 'python-mode)
  (add-to-list 'page-break-lines-modes 'sh-mode)
  (add-to-list 'page-break-lines-modes 'shell-script-mode))

(dolist ; display-buffer-alist
    (alist '(
             ;; ("^\\*helpful"
             ;;  (display-buffer-reuse-window display-buffer-below-selected)
             ;;  (reusable-frames . nil))
             ;; ("^\\*lsp-help*"
             ;;  (display-buffer-reuse-window display-buffer-below-selected)
             ;;  (reusable-frames . nil))
             ;; ESS
             ;; ("^\\*ess-describe"
             ;;  (display-buffer-reuse-window display-buffer-same-window)
             ;;  (reusable-frames . nil))
             ;; ("^\\*help\\[R\\]("
             ;;  (display-buffer-reuse-window display-buffer-in-side-window)
             ;;  (side . right)
             ;;  (slot . -1)
             ;;  (window-width . 0.5)
             ;;  (reusable-frames . nil))
             ;; ("^\\*R"
             ;;  (display-buffer-reuse-window display-buffer-in-side-window)
             ;;  (side . left)
             ;;  (reusable-frames . nil))
             ;; ("^\\*R dired"
             ;;  (display-buffer-reuse-window display-buffer-in-side-window)
             ;;  (side . right)
             ;;  (slot . -1)
             ;;  (window-width . 0.2)
             ;;  (reusable-frames . nil))
             ))
  (add-to-list 'display-buffer-alist alist))


;;; org

(use-package org
  :defer t

  :hook
  (org-mode . visual-line-mode)

  :config
  (setq org-directory (expand-file-name "~/Dropbox/repos/github/five-dots/notes/org"))

  ;; appearance
  ;; replace "-" with "•"
  (font-lock-add-keywords
    'org-mode
    '(("^ *\\([-]\\) "
      (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (setq org-hide-emphasis-markers t)

  ;; faces
  (set-face-attribute 'org-level-1 nil :slant 'italic :height 1.1)
  ;; (set-face-attribute 'org-block-end-line nil :foreground "#23272e")

  ;; todo
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAIT(w)" "HOLD(h)" "DONE(d)")
          (sequence "[ ](T)" "[-](S)" "[X](D)")))
  ;; agenda
  ;; Add agenda file recursively
  ;; https://www.reddit.com/r/orgmode/comments/6q6cdk/adding_files_to_the_agenda_list_recursively/
  (setq org-agenda-files
        (apply 'append
               (mapcar (lambda (directory)
                         (directory-files-recursively directory org-agenda-file-regexp))
                       '("~/Dropbox/repos/github/five-dots/notes/org"))))

  ;; agenda format
  ;; Aligned Agenda View. Anyway to make this more clean? IE, having the TODO Keywords all line up?
  ;; https://www.reddit.com/r/orgmode/comments/6ybjjw/aligned_agenda_view_anyway_to_make_this_more/
  ;; (setq org-agenda-prefix-format
  ;;       (quote
  ;;        ((agenda . " %i %-12:c%?12t% s")
  ;;         (todo   . " %i %-12:c")
  ;;         (tags   . " %i %-12:c")
  ;;         (search . " %i %-12:c"))))

  ;; babel
  (setq org-confirm-babel-evaluate nil)
  (setq org-src-preserve-indentation t)
  (setq org-src-window-setup 'split-window-below)

  ;; org-mode fontification error with org src blocks #8455
  ;; https://github.com/syl20bnr/spacemacs/issues/8455
  (setq org-src-fontify-natively t)

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

  ;; latex preview
  (setq org-preview-latex-image-directory "~/Dropbox/memo/img/latex/")
  ;; (setq org-preview-latex-default-process 'dvisvgm)
  (plist-put org-format-latex-options :scale 1.5)

  ;; projectile
  (setq org-projectile-file "TODOs.org")

  ;; exporter
  (add-to-list 'org-export-filter-latex-fragment-functions 'my/org-replace-latex-wrap)

  ;; keybindings
  (spacemacs/set-leader-keys-for-major-mode 'org-mode
    "TI" #'org-toggle-item
    "Th" #'org-toggle-heading
    ))

(use-package org-download
  :disabled ; use org-superstar
  :defer t

  :config
  (setq org-download-image-dir
        (expand-file-name "~/Dropbox/memo/img/download")))

(use-package org-bullets
  :defer t
  :config
  (setq org-bullets-bullet-list '("◉" "" "" "" "" "" "" "" "" "")))

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

(progn ; ox-ravel
  (add-to-list 'load-path "~/repos/github/chasberry/orgmode-accessories")
  (require 'ox-ravel))

(use-package ox-hugo
  :after ox

  :config
  (setq org-hugo-section "post")
  (setq org-hugo-front-matter-format "toml") ; toml or yaml
  (setq org-hugo-use-code-for-kbd t))


;;; lang

(progn ; company-backends for emacs-lisp-mode
  ;; (eval-after-load 'company
  ;;   (spacemacs|add-company-backends
  ;;     :backends
  ;;     (company-capf
  ;;      company-files
  ;;      :with company-yasnippet)
  ;;     :modes emacs-lisp-mode))
  )

(use-package company-shell
  :defer t

  :init
  (spacemacs|add-company-backends
    :backends
    (company-shell company-shell-env company-files :with company-yasnippet)
    :modes sh-mode))

(use-package python
  :config
  (require 'eval-in-repl-python)

  (setq python-shell-interpreter "python3") ; "python3" or "ipython3"
  (when (string-equal python-shell-interpreter "python3")
    (setq python-shell-interpreter-args "-i"))

  (setq org-babel-python-command "python3")

  (setq python-shell-completion-native-enable nil) ; default t
  (add-to-list 'python-shell-completion-native-disabled-interpreters
               "python3")

  ;; https://github.com/jorgenschaefer/elpy/issues/733
  ;; (setq python-shell-prompt-detect-enabled nil)
  ;; (setq python-shell-prompt-detect-failure-warning nil)

  ;; Can’t guess python-indent-offset, using defaults: 4... のメッセージを表示しない
  (setq python-indent-guess-indent-offset-verbose nil))

(use-package stan-mode
  :load-path
  "~/Dropbox/repos/github/kaz-yos/stan-mode/stan-mode"

  :mode
  ("\\.stan\\'" . stan-mode)

  :hook
  (stan-mode . stan-mode-setup)

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
  :defer t

  ;; :init
  ;; (add-hook 'lsp-mode-hook 'my/set-company-backend-for-lsp)

  :config
  ;; (setq lsp-document-sync-method 'incremental)
  ;; (setq lsp-enable-completion-at-point nil)
  ;; (setq lsp-prefer-flymake nil) ; flymake or lsp-ui
  (setq lsp-session-file (expand-file-name ".cache/lsp-session" user-emacs-directory))

  ;; lsp-signature-mode
  (setq lsp-signature-render-documentation nil))

(use-package lsp-ui
  :defer t

  :config
  ;; (defun my/toggle-lsp-ui-doc ()
  ;;   (interactive)
  ;;   (if lsp-ui-doc-mode
  ;;       (progn
  ;;         (lsp-ui-doc-mode -1)
  ;;         (lsp-ui-doc--hide-frame))
	;;     (lsp-ui-doc-mode 1)))

  ;; lsp-ui-doc
  ;; (setq lsp-ui-doc-enable nil)
  ;; (setq lsp-ui-doc-header nil)
  ;; (setq lsp-ui-doc-include-signature nil)
  ;; (setq lsp-ui-doc-position 'at-point)
  ;; (setq lsp-ui-doc-max-width 150)
  (setq lsp-ui-doc-max-height 30)
  ;; (setq lsp-ui-doc-use-childframe t)
  ;; (setq lsp-ui-doc-use-webkit nil)
  (setq lsp-ui-doc-delay 1.0)

  ;; lsp-ui-flycheck
  ;; (setq lsp-ui-flycheck-enable t)

  ;; lsp-ui-peek
  ;; (setq lsp-ui-peek-enable t)
  ;; (setq lsp-ui-peek-peek-height 20)
  ;; (setq lsp-ui-peek-list-width 50)
  ;; (setq lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always

  ;; lsp-ui-imenu
  ;; (setq lsp-ui-imenu-enable nil)
  ;; (setq lsp-ui-imenu-kind-position 'top)

  ;; lsp-ui-sideline
  ;; (setq lsp-ui-sideline-enable nil)
  ;; (setq lsp-ui-sideline-enable nil)
  ;; (setq lsp-ui-sideline-ignore-duplicate t) ; nil
  ;; (setq lsp-ui-sideline-show-symbol t)
  ;; (setq lsp-ui-sideline-show-hover t) ; nil
  ;; (setq lsp-ui-sideline-show-diagnostics nil) ; t
  ;; (setq lsp-ui-sideline-show-code-actions nil) ;t
  ;; (setq lsp-ui-sideline-code-actions-prefix "")
  )

(use-package lsp-python-ms
  :config
  (setq lsp-python-ms-python-executable-cmd "python3"))

;; (use-package company-lsp
;;   :config
;;   (setq company-lsp-cache-candidates t)
;;   (setq company-lsp-enable-recompletion nil))

(use-package dap-mode
  ;; TODO dap-ui-mode debug 実行時のウィンドウレイアウト
  ;; TODO hydra map を自動で表示したい

  :defer t

  :hook (dap-mode . my/change-fringe-width)

  :config
  (setq dap-breakpoints-file
        (expand-file-name ".cache/dap-breakpoints" user-emacs-directory))
  (use-package dap-python
    :config
    (setq dap-python-executable "python3"))
  (use-package dap-gdb-lldb))

(use-package flycheck
  :defer t

  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabed))

  ;; TODO move to my-ess layer
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

(use-package sql
  :defer t

  :config
  (setq sql-connection-alist
        '((rds-psql-market-data-01
           (sql-product 'postgres)
           (sql-server "psql-market-data-01.cuqrjz6jimsm.ap-northeast-1.rds.amazonaws.com")
           (sql-user "shun")
           (sql-database "test")
           (sql-port 5432))
          (rds-psql-test-01
           (sql-product 'postgres)
           (sql-server "psql-test-01.cuqrjz6jimsm.ap-northeast-1.rds.amazonaws.com")
           (sql-user "shun")
           (sql-database "rdataset")
           (sql-port 5432))
          (redshift-cluster-1
           (sql-product 'postgres)
           (sql-server "redshift-cluster-1.cnheyicocvox.ap-northeast-1.redshift.amazonaws.com")
           (sql-user "awsuser")
           (sql-database "dev")
           (sql-port 5439)))))


;;; tool

(use-package vc
  :defer t

  :config
  (setq vc-follow-symlinks t))

(use-package magit
  :config
  (setq magit-branch-read-upstream-first 'fallback))

(use-package google-translate
  :defer t

  :init
  (setq google-translate-pop-up-buffer-set-focus t)
  ;; (setq google-translate-default-source-language "en") ; default "auto"
  (setq google-translate-default-target-language "ja")
  (spacemacs/set-leader-keys "xgg" 'google-translate-at-point))

(use-package ibus
  :disabled

  :hook
  (after-init . ibus-mode-on)

  :load-path "~/Dropbox/repos/public/ibus-el-0.3.2"

  :config
  (ibus-define-common-key 'henkan t)

  ;; C-SPC は Set Mark に使う
  ;; (ibus-define-common-key ?C-s nil)
  ;; C-/ は Undo に使う
  ;; (ibus-define-common-key ?C-/ nil)

  ;; IBus の状態によってカーソル色を変化させる ("on" "off" "disabled")
  ;; (setq ibus-cursor-color '("firebrick" "dark orange" "royal blue"))

  ;; すべてのバッファで入力状態を共有 (default ではバッファ毎にインプットメソッドの状態を保持)
  ;; (setq ibus-mode-local nil)

  ;; カーソル位置で予測候補ウィンドウを表示 (default はプリエディット領域の先頭位置に表示)
  (setq ibus-prediction-window-position t) ; nil, t or 0
  )

(use-package calendar
  :config
  (setq calendar-week-start-day 1) ; start from Mon
  (setq calendar-mark-holidays-flag t))

(use-package window-purpose
  :config
  (setq purpose-default-layout-file
        (expand-file-name "purpose-layout" spacemacs-cache-directory))

  ;; set purpose
  (add-to-list 'purpose-user-mode-purposes
               '(helpful-mode . helpful))
  (purpose-compile-user-configuration)

  ;; display rules
  (add-to-list 'purpose-special-action-sequences
               '(helpful
                 purpose-display-reuse-window-buffer
                 purpose-display-reuse-window-purpose
                 display-buffer-below-selected)))


;;; keybindings

(when my/mac-p ; mac modifiers
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'hyper))

(spacemacs/set-leader-keys ; leader keys
  "," #'ivy-switch-buffer
  "." #'ivy-resume

  ;; applications
  "al" #'counsel-linux-app
  "ac" #'my/open-calendar
  "aC" #'calc-dispatch

  ;; buffer
  "b b" #'ivy-switch-buffer

  ;; windows
  "w/" #'split-window-right-and-focus
  "wv" #'split-window-right-and-focus
  "wV" #'split-window-right
  "w-" #'split-window-below-and-focus
  "ws" #'split-window-below-and-focus
  "wS" #'split-window-below
  "ww" #'ace-window
  "wW" #'other-window
 )

(evil-define-key '(motion) 'global ; remap evil motion key
  ;; j/k
  "j"  #'evil-next-visual-line
  "gj" #'evil-next-line
  "k"  #'evil-previous-visual-line
  "gk" #'evil-previous-line

  ;; 0/^
  "0"  #'evil-first-non-blank
  "g0" #'evil-first-non-blank-of-visual-line
  "^"  #'evil-digit-argument-or-evil-beginning-of-line
  "g^" #'evil-beginning-of-visual-line)

(progn ; hyper prefix keys
  (evil-define-key '(motion) 'global
    (kbd "H-'") #'evil-avy-goto-char-2
    (kbd "H-,") #'ivy-switch-buffer
    (kbd "H-/") #'swiper-isearch
    (kbd "H-b") #'evil-backward-char

    ;; window navigation
    (kbd "C-H-h") #'evil-window-left
    (kbd "C-H-j") #'evil-window-down
    (kbd "C-H-k") #'evil-window-up
    (kbd "C-H-l") #'evil-window-right)

  (evil-define-key '(insert) 'global
    (kbd "H-N") #'backward-kill-word))

(progn ; z prefix keys
  (evil-define-key '(motion) 'global
    "z;" #'save-buffer
    "zx" #'spacemacs/kill-this-buffer))

(bind-keys ; help-map
 :map help-map
 ("<f1>"   . nil) ; help-for-help
 ("<help>" . nil) ; help-for-help
 ("C-h"    . nil) ; help-for-help
 ("C-n"    . nil) ; view-emacs-news
 ("C-\\"   . nil) ; describe-input-method
 ("a" . counsel-apropos)
 ("b" . counsel-descbinds)
 ("f" . counsel-describe-function)
 ("k" . helpful-key)
 ("v" . counsel-describe-variable))

(bind-keys ; comint-mode-map
 :map comint-mode-map
 ("C-l" . comint-clear-buffer))

(progn ; python-mode-map
  (bind-keys
   :map python-mode-map
   ("C-<return>" . eir-eval-in-python))

  (spacemacs/declare-prefix-for-mode 'python-mode "ms" nil)
  (spacemacs/declare-prefix-for-mode 'python-mode "me" "eval")
  (spacemacs/set-leader-keys-for-major-mode 'python-mode
    "eB" 'spacemacs/python-shell-send-buffer-switch
    "eb" 'spacemacs/python-shell-send-buffer
    "eF" 'spacemacs/python-shell-send-defun-switch
    "ef" 'spacemacs/python-shell-send-defun
    "ei" 'spacemacs/python-start-or-switch-repl
    "eR" 'spacemacs/python-shell-send-region-switch
    "er" 'spacemacs/python-shell-send-region)
  )
