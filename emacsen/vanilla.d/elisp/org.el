;;; org

(use-package org-bullets
  :hook
  (org-mode . org-bullets-mode)

  :config
  (setq org-bullets-bullet-list '("" "" "" "" "" "" "" "" "" "")))

(use-package org-variable-pitch :disabled
  :commands
  (org-variable-pitch-minor-mode)

  :hook
  (org-mode . org-variable-pitch-minor-mode)

  :config
  (dolist (f org-variable-pitch-fixed-faces)
    (set-face-attribute f nil :fontset "fontset-auto1" :font "fontset-auto1")))

(use-package org-download
  :defer t

  :config
  (setq org-download-image-dir (expand-file-name "~/Dropbox/memo/img/download")))

;; TODO org-capture
;; TODO org-agenda
;; TODO org-pomodoro

(use-package evil-org
  :hook (org-mode . evil-org-mode))

(use-package org
  ;; Adding files to the agenda list recursively?
  ;; https://www.reddit.com/r/orgmode/comments/6q6cdk/adding_files_to_the_agenda_list_recursively/

  ;; Aligned Agenda View. Anyway to make this more clean? IE, having the TODO Keywords all line up?
  ;; https://www.reddit.com/r/orgmode/comments/6ybjjw/aligned_agenda_view_anyway_to_make_this_more/

  :config
  ;; Replace "-" with "•"
  (font-lock-add-keywords
   'org-mode
   '(("^ *\\([-]\\) "
      (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (setq org-hide-emphasis-markers t)

  ;; org faces
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

  ;; Latex preview
  (setq org-preview-latex-image-directory "~/Dropbox/memo/img/latex/")
  ;; (setq org-preview-latex-default-process 'dvisvgm)
  (plist-put org-format-latex-options :scale 1.5)

  ;; Error running timer ‘org-indent-initialize-agent’: (void-function org-time-add) #129
  ;; https://github.com/seagle0128/.emacs.d/issues/129
  (org-reload))

(use-package org-babel-eval-in-repl :disabled
  :general
  ('(normal visual)
   org-mode-map
   "C-<return>" #'ober-eval-in-repl))

(use-package poly-org :disabled
  :hook
  (org-mode . poly-org-mode))

(use-package ob-async)

(use-package ox-qmd :disabled
  :defer t
  :straight nil
  :load-path "~/Dropbox/repos/github/0x60df/ox-qmd"
  :config
  (add-to-list 'ox-qmd-language-keyword-alist '("R" . "r")))

(use-package org-qiita :disabled
  ;; post qiita from emacs
  ;; https://qiita.com/dwarfJP/items/594a8d4b0ac6d248d1e4

  :straight nil

  :load-path
  "~/Dropbox/repos/github/ifritJP/org-qiita-el"

  :config
  (setq org-qiita-token my/qiita-token)
  (setq org-qiita-export-and-post nil))

(use-package ox-hugo :disabled
  :defer t

  :config
  (setq org-hugo-section "post")
  (setq org-hugo-front-matter-format "toml") ; toml or yaml
  (setq org-hugo-use-code-for-kbd t))

(use-package ox-hatena :disabled
  :straight nil
  :load-path
  "~/Dropbox/repos/github/akisute3/ox-hatena")

;; org-mode-map
(progn
  (defvar my/org-mode-xxx-map (make-sparse-keymap))

  (general-def
    my/org-mode-xxx-map)

  (my/local-leader-def
   '(normal visual)
   org-mode-map
   "," #'org-ctrl-c-ctrl-c
   ))
