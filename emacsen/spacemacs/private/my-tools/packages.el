;;; packages.el --- my-tools layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Shun Asai <syun.asai@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst my-tools-packages
  '(
    crontab-mode
    ;; dotnet
    ;; exec-path-from-shell
    ;; evil-fringe-mark
    eval-in-repl
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
    ;; org-superstar
    ;; (ox-hatena :location (recipe :fetcher github :repo "yynozk/ox-hatena"))
    (ox-qmd :location (recipe :fetcher github :repo "0x60df/ox-qmd"))
    ))

;; (defun my-tools/init-undohist ()
;;   (use-package undohist
;;     :config
;;     (setq undohist-directory (expand-file-name "undohist" spacemacs-cache-directory))))

(defun my-tools/init-crontab-mode ()
  (use-package crontab-mode
    :mode (("\\.cron\\(tab\\)?\\'" . crontab-mode)
           ("cron\\(tab\\)?\\." . crontab-mode))))

;; (defun my-tools/init-dotnet ()
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

;; (defun my-tools/init-evil-fringe-mark ()
;;   (use-package exec-path-from-shell
;;     :init
;;     (global-evil-fringe-mark-mode)
;;     (setq-default left-fringe-width 16)))

;; (defun my-tools/init-exec-path-from-shell ()
;;   (use-package exec-path-from-shell
;;     :config
;;     (exec-path-from-shell-initialize)))

(defun my-tools/init-eval-in-repl ()
  (use-package eval-in-repl
    :config
    ;; Echo command text in REPL
    (setq eir-use-python-shell-send-string nil)))


(defun my-tools/init-google-this ()
  (use-package google-this
    :commands google-this))

(defun my-tools/init-helpful ()
  (use-package helpful
    ;; helpful commands
    ;; - helpful-callable
    ;; - helpful-function
    ;; - helpful-macro
    ;; - helpful-command
    ;; - helpful-key
    ;; - helpful-variable
    ;; - helpful-at-point

    :defer t

    :init
    (setq counsel-describe-function-function #'helpful-callable)
    (setq counsel-describe-variable-function #'helpful-variable)

    (dolist (mode '(emacs-lisp-mode lisp-interaction-mode))
      (spacemacs/set-leader-keys-for-major-mode mode
        "h h" #'helpful-at-point))
    ))

;; (defun my-tools/init-lispy ()
;;   (use-package lispy
;;     ;; :hook
;;     ;; (emacs-lisp-mode . lispy-mode)
;;     ;; (lisp-interaction-mode . lispy-mode)
;;     ))

(defun my-tools/init-lispxmp ()
  (use-package lispxmp
    :config
    (spacemacs/set-leader-keys-for-major-mode 'emacs-lisp-mode
      "e x" 'lispxmp)
    (spacemacs/set-leader-keys-for-major-mode 'lisp-interaction-mode
      "e x" 'lispxmp)))

;; (defun my-tools/init-recentf-ext ()
;;   (use-package recentf-ext))

(defun my-tools/init-magit-todos ()
  (use-package magit-todos))

(defun my-tools/init-quickrun ()
  (use-package quickrun))

;; (defun my-tools/init-hatena-blog-mode ()
;;   (use-package hatena-blog-mode
;;     :config
;;     (setq hatena-id "five-dots")
;;     (setq hatena-blog-api-key my/hatena-blog-api-key)
;;     (setq hatena-blog-id "five-dots.hatenablog.com")
;;     (setq hatena-blog-editing-mode "md")
;;     (setq hatena-blog-backup-dir nil)))

(defun my-tools/init-visual-regexp ()
  (use-package visual-regexp))

(defun my-tools/init-visual-regexp-steroids ()
  (use-package visual-regexp-steroids))


;;; org-mode

(defun my-tools/init-ox-qmd ()
  (use-package ox-qmd
    :config
    (add-to-list 'ox-qmd-language-keyword-alist
                 '("R" . "r"))))

;; (defun my-tools/init-ox-hatena ()
;;   (use-package ox-hatena))

;; (defun my-tools/init-org-superstar ()
;;   (use-package org-superstar
;;     :hook
;;     (org-mode . org-superstar-mode)

;;     :config
;;     ;; Make leading stars truly invisible, by rendering them as spaces!
;;     (setq org-superstar-leading-bullet ?\s
;;           org-superstar-leading-fallback ?\s
;;           org-hide-leading-stars nil)

;;     ;; Don't do anything special for item bullets or TODOs by default;
;;     ;; these slow down larger org buffers.
;;     (setq org-superstar-prettify-item-bullets nil
;;           org-superstar-special-todo-items nil
;;           ;; ...but configure it in case the user wants it later
;;           org-superstar-todo-bullet-alist
;;           '(("TODO" . 9744)
;;             ("[ ]"  . 9744)
;;             ("DONE" . 9745)
;;             ("[X]"  . 9745)))

;;     (setq org-superstar-headline-bullets-list
;;           '("◉" "" "" "" "" "" "" "" "" ""))))
