;;; packages.el --- my-calendar layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Shun Asai <syun.asai@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst my-calendar-packages
  '(
    calfw
    calfw-org
    calfw-ical
    org-gcal
    ))

(defun my-calendar/init-calfw ()
  (use-package calfw
    :commands
    cfw:open-calendar-buffer

    :config
    ;; better frame for calendar
    (setq cfw:face-item-separator-color nil
          cfw:render-line-breaker 'cfw:render-line-breaker-none
          cfw:fchar-junction ?╋
          cfw:fchar-vertical-line ?┃
          cfw:fchar-horizontal-line ?━
          cfw:fchar-left-junction ?┣
          cfw:fchar-right-junction ?┫
          cfw:fchar-top-junction ?┯
          cfw:fchar-top-left-corner ?┏
          cfw:fchar-top-right-corner ?┓)

    (bind-keys
     :map cfw:calendar-mode-map
     ("q"   . bury-buffer)
     ("C-g" . bury-buffer)
     ("RET" . cfw:show-details-command)
     ("C-H-h" . evil-window-left)
     ("C-H-j" . evil-window-down)
     ("C-H-k" . evil-window-up)
     ("C-H-l" . evil-window-right))

    (evil-define-key '(normal) cfw:details-mode-map
      "q" #'kill-this-buffer)))

(defun my-calendar/init-calfw-org ()
  (use-package calfw-org
    :commands (cfw:open-org-calendar
               cfw:org-create-source
               cfw:open-org-calendar-withkevin
               my-open-calendar)))

(defun my-calendar/init-calfw-ical ()
  (use-package calfw-ical))

(defun my-calendar/init-org-gcal ()
  (use-package org-gcal
    :disabled

    :commands (org-gcal-sync
               org-gcal-fetch
               org-gcal-post-at-point
               org-gcal-delete-at-point)

    :init
    (setq org-gcal-dir (concat spacemacs-cache-directory "org-gcal/"))
    (setq org-gcal-token-file (concat org-gcal-dir "token.gpg"))

    :config
    ;; hack to avoid the deferred.el error
    (defun org-gcal--notify (title mes)
      (message "org-gcal::%s - %s" title mes))
    ))
