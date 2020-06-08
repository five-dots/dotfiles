;;; packages.el --- my-ui layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Shun Asai <syun.asai@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst my-ui-packages
  '(
    beacon
    centaur-tabs
    hide-mode-line
    highlight-indent-guides
    hl-fill-column
    ))

(defun my-ui/init-centaur-tabs ()
  (use-package centaur-tabs
    :disabled

    :hook
    (after-init . centaur-tabs-mode)
    ;; disabled modes
    (treemacs-mode . centaur-tabs-local-mode)

    :config
    (setq centaur-tabs-style "bar")
    (setq centaur-tabs-set-icons t)
    (setq centaur-tabs-gray-out-icons 'buffer)
    (setq centaur-tabs-set-bar 'left)
    (setq centaur-tabs-cycle-scope 'tabs)

    ;; Prevent the access to specified buffers
    (defun centaur-tabs-hide-tab (x)
      (let ((name (format "%s" x)))
        (or
         ;; * で始まるバッファ
         (and (string-prefix-p "*" name)
              ;; (not) で除外するバッファを指定
              (not (string-prefix-p "*R" name))
              (not (string-prefix-p "*Python" name))
              (not (string-prefix-p "*shell" name))
              (not (string-prefix-p "*ansi-term" name))
              (not (string-prefix-p "*eshell" name)))
         ;; magit
         (string-prefix-p "COMMIT_EDITMSG" name)
         (and (string-prefix-p "magit" name)
              (not (file-name-extension name))))))

    ;; buffer group function
    (defun centaur-tabs-buffer-groups ()
      (list
       (cond
        ((memq major-mode '(inferior-ess-r-mode
                            inferior-python-mode
                            eshell-mode
                            term-mode
                            ))
         "repl")
        ((derived-mode-p 'prog-mode)
         "coding")
        ((memq major-mode '(markdown-mode
                            text-mode
                            org-mode
                            org-src-mode
                            org-agenda-mode))
         "editing")
        ;; ((string-prefix-p "*" (buffer-name))
        ;;  "emacs")
        (t "other"))))

    ;; keymaps
    (spacemacs/set-leader-keys
      "RET" 'centaur-tabs-counsel-switch-group)
    (evil-define-key '(normal) 'global
      (kbd "C-M-,") 'centaur-tabs-backward
      (kbd "C-M-.") 'centaur-tabs-forward)
    (centaur-tabs-headline-match)))

(defun my-ui/init-hide-mode-line ()
  (use-package hide-mode-line
    :defer t
    :hook
    (treemacs-mode     . hide-mode-line-mode)
    (ess-r-help-mode   . hide-mode-line-mode)
    (help-mode         . hide-mode-line-mode)
    (helpful-mode      . hide-mode-line-mode)
    (cfw:calendar-mode . hide-mode-line-mode)
    ))

(defun my-ui/init-highlight-indent-guides ()
  (use-package highlight-indent-guides
    :hook
    ;; (emacs-lisp-mode . highlight-indent-guides-mode)
    ;; (ess-r-mode . highlight-indent-guides-mode)
    (csharp-mode . highlight-indent-guides-mode)
    :config
    ;; (setq highlight-indent-guides-responsive t)
    (setq highlight-indent-guides-method 'character)))

(defun my-ui/init-hl-fill-column ()
  (use-package hl-fill-column
    :disabled

    :hook
    ((prog-mode text-mode conf-mode) . hl-fill-column-mode)))

(defun my-ui/init-beacon ()
  (use-package beacon
    :disabled

    :defer t

    :hook (after-init . beacon-mode)

    :config
    (setq beacon-blink-when-window-scrolls nil)))
