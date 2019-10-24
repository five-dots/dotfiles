;;; packages.el --- my-tools layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: shun <shun@desk1>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst my-tools-packages
  '(
    crontab-mode
    dotnet
    exec-path-from-shell
    google-this
    helpful
    lispxmp
    lispy
    magit-todos
    quickrun
    recentf-ext
    undohist
    ))

(defun my-tools/init-crontab-mode ()
  (use-package crontab-mode
    :mode (("\\.cron\\(tab\\)?\\'" . crontab-mode)
           ("cron\\(tab\\)?\\."    . crontab-mode))))

(defun my-tools/init-dotnet ()
  (use-package dotnet
    :hook
    (csharp-mode . dotnet-mode)
    :config
    (spacemacs/declare-prefix-for-mode 'csharp-mode "mc" "dotnet-cli")
    (spacemacs/declare-prefix-for-mode 'csharp-mode "mcg" "goto")
    (spacemacs/declare-prefix-for-mode 'csharp-mode "mcs" "sln")
    (spacemacs/set-leader-keys-for-major-mode 'csharp-mode
      "c ." 'dotnet-run
      "c b" 'dotnet-build
      "c c" 'dotnet-clean
      "c n" 'dotnet-new
      "c p" 'dotnet-add-package
      "c r" 'dotnet-add-reference
      "c t" 'dotnet-test
      ;; goto
      "c g p" 'dotnet-goto-csproj
      "c g s" 'dotnet-goto-sln
      ;; sln
      "c s l" 'dotnet-sln-list
      "c s n" 'dotnet-sln-new
      "c s r" 'dotnet-sln-remove)))

(defun my-tools/init-exec-path-from-shell ()
  (use-package exec-path-from-shell
    :config
    (exec-path-from-shell-initialize)))

(defun my-tools/init-google-this ()
  (use-package google-this
    :commands google-this))

(defun my-tools/init-helpful ()
  (use-package helpful
    :defer t
    ;; TODO evilify helpful-mode
    ;; :init
    ;; (setq counsel-describe-function-function #'helpful-callable)
    ;; (setq counsel-describe-variable-function #'helpful-variable)
    ))

(defun my-tools/init-lispy ()
  (use-package lispy
    ;; :hook
    ;; (emacs-lisp-mode . lispy-mode)
    ;; (lisp-interaction-mode . lispy-mode)
    ))

(defun my-tools/init-lispxmp ()
  (use-package lispxmp
    :config
    (spacemacs/set-leader-keys-for-major-mode 'emacs-lisp-mode
      "e x" 'lispxmp)
    (spacemacs/set-leader-keys-for-major-mode 'lisp-interaction-mode
      "e x" 'lispxmp)))

(defun my-tools/init-recentf-ext ()
  (use-package recentf-ext)
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 60)
  (run-with-idle-timer 60 t 'recentf-save-list))

(defun my-tools/init-magit-todos ()
  (use-package magit-todos))

(defun my-tools/init-quickrun ()
  (use-package quickrun))

(defun my-tools/init-undohist ()
  (use-package undohist
    :config
    (setq undohist-directory (expand-file-name "undohist" spacemacs-cache-directory))))
