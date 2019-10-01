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
    hide-mode-line
    beacon
    ivy-posframe
    ))

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
