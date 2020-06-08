;;; misc

(use-package projectile
  :config
  (setq projectile-known-projects-file
        (expand-file-name "projectile-bookmarks" my/cache-dir)))

(use-package recentf
  :config
  ;; recentf per host
  (setq recentf-save-file (expand-file-name "recentf" my/cache-dir))
  (setq recentf-max-saved-items 1000)
  (setq recentf-exclude '(".recentf")))

(use-package recentf-ext)

(use-package restart-emacs
  :defer t
  :general
  (general-define-key
   :states '(normal visual)
   :prefix "SPC q"
   "r" '(restart-emacs :which-key "restart")
   "q" '(kill-emacs :which-key "quit")))

(use-package smartparens
  ;; https://github.com/Fuco1/smartparens

  :defer t

  :hook
  (prog-mode . smartparens-mode)

  :config
  (use-package smartparens-config
    :straight nil
    :load-path
    "~/.emacs.d/straight/build/smartparens")
  (setq sp-highlight-pair-overlay nil))

(use-package highlight-parentheses)

(use-package helpful
  ;; https://www.tradingview.com/chart/oSKh7lXc/

  ;; helpful commands
  ;; - helpful-callable
  ;; - helpful-function
  ;; - helpful-macro
  ;; - helpful-command
  ;; - helpful-key
  ;; - helpful-variable
  ;; - helpful-at-point

  :after counsel

  :defer t

  :init
  (setq counsel-describe-function-function #'helpful-callable) ; both function and macro 
  (setq counsel-describe-variable-function #'helpful-variable))

(use-package winum
  :hook (after-init . winum-mode))

(use-package ace-window
  :defer t
  :config
  (setq aw-keys '(?a ?s ?d ?f ?j ?k ?l)))

(use-package google-this
  :defer t)

(use-package undo-tree
  :defer t
  :general
  (general-define-key
   :states '(normal visual)
   :prefix "SPC a"
   "u" 'undo-tree-visualize))

(use-package undohist
  :config
  (setq undohist-directory (expand-file-name "undohist" my/cache-dir))
  (undohist-initialize))

(use-package aggressive-indent :disabled
  :hook
  (prog-mode . aggressive-indent-mode))

(use-package crontab-mode
  :straight nil

  :load-path "~/Dropbox/repos/private/elisp/crontab-mode"

  :mode (("\\.cron\\(tab\\)?\\'" . crontab-mode)
         ("cron\\(tab\\)?\\." . crontab-mode)))

(use-package quickrun
  :defer t)

(use-package visual-regexp
  :defer t)

(use-package visual-regexp-steroids
  :defer t)

;; misc
(progn 
  (defalias 'yes-or-no-p 'y-or-n-p "yes or no shortcut")
  (setq-default tab-width 4)
  ;; backup file location
  (add-to-list 'backup-directory-alist
               (cons ".*" (expand-file-name "backup" my/cache-dir)))
  ;; auto-save file location
  (setq auto-save-list-file-prefix
        (expand-file-name "auto-save/" my/cache-dir)))
