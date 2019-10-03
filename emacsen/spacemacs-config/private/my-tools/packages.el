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
    evil-vimish-fold
    exec-path-from-shell
    google-this
    helpful
    lispxmp
    recentf-ext
    ))

(defun my-tools/init-crontab-mode ()
  (use-package crontab-mode
    :mode (("\\.cron\\(tab\\)?\\'" . crontab-mode)
           ("cron\\(tab\\)?\\."    . crontab-mode))))

(defun my-tools/init-recentf-ext ()
  (use-package recentf-ext)
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 60)
  (run-with-idle-timer 60 t 'recentf-save-list))

(defun my-tools/init-evil-vimish-fold ()
  (use-package evil-vimish-fold
    :config
    (setq vimish-fold-dir
          (expand-file-name "vimish-fold/" spacemacs-cache-directory))
    (evil-vimish-fold-mode 1)))

(defun my-tools/init-exec-path-from-shell ()
  (use-package exec-path-from-shell
    :config
    (exec-path-from-shell-initialize)))

(defun my-tools/init-lispxmp ()
  (use-package lispxmp
    :config
    (spacemacs/set-leader-keys-for-major-mode 'emacs-lisp-mode
      "e x" 'lispxmp)
    (spacemacs/set-leader-keys-for-major-mode 'lisp-interaction-mode
      "e x" 'lispxmp)))

(defun my-tools/init-google-this ()
  (use-package google-this
    :commands google-this))
