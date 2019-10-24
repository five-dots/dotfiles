;;; packages.el --- my-ui layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: shun <shun@x1>
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
    ivy-posframe
    ))

(defun my-ui/init-centaur-tabs ()
  (use-package centaur-tabs
    :hook
    (after-init . centaur-tabs-mode)
    ;; disabled modes
    (treemacs-mode . centaur-tabs-local-mode)

    :config
    (setq centaur-tabs-style "bar")
    (setq centaur-tabs-set-icons t)
    (setq centaur-tabs-gray-out-icons t)
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
                            eshell-mode))
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
    (bind-keys :map evil-normal-state-map
               ("C-M-," . centaur-tabs-backward)
               ("C-M-." . centaur-tabs-forward))
    (centaur-tabs-headline-match)))

(defun my-ui/init-hide-mode-line ()
  (use-package hide-mode-line
    :defer t
    :hook (treemacs-mode . hide-mode-line-mode)))

(defun my-ui/init-beacon ()
  (use-package beacon
    :defer t
    :hook (after-init . beacon-mode)
    :config
    (setq beacon-blink-when-window-scrolls nil)))

(defun my-ui/init-ivy-posframe ()
  (use-package ivy-posframe
    :init
    (ivy-posframe-mode 1)
    :config
    (setq ivy-posframe-border-width 1)
    (setq ivy-posframe-min-width 90)
    (setq ivy-posframe-min-height 11)
    (setq ivy-posframe-height 11)
    (setq ivy-posframe-parameters
          '((left-fringe . 5)
            (right-fringe . 5)))
    (setq ivy-posframe-display-functions-alist
          '((swiper . ivy-display-function-fallback)
            (swiper-all . ivy-display-function-fallback)
            (counsel-rg . ivy-display-function-fallback)
            (counsel-yank-pop . ivy-display-function-fallback)
            (t . ivy-posframe-display-at-frame-center)))
    :custom-face
    (ivy-posframe ((t (:background "#282a36"))))
    (ivy-posframe-border ((t (:background "#6272a4"))))
    (ivy-posframe-cursor ((t (:background "#61bfff"))))))
