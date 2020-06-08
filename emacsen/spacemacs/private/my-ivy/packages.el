;;; packages.el --- my-ivy layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Shun Asai <syun.asai@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst my-ivy-packages
  '(
    ivy-posframe
    all-the-icons-ivy-rich
    ))

(defun my-ivy/init-all-the-icons-ivy-rich ()
  (use-package all-the-icons-ivy-rich
    ;; Better experience with icons
    ;; Enable it before`ivy-rich-mode' for better performance
    ;; https://github.com/seagle0128/all-the-icons-ivy-rich

    :hook
    (ivy-mode . all-the-icons-ivy-rich-mode)

    :init
    (setq all-the-icons-ivy-rich-icon-size 0.8)

    :config
    (let ((switch-buffer-trans
           '(:columns
             ((all-the-icons-ivy-rich-buffer-icon)
              (ivy-rich-candidate (:width 30))
              (ivy-rich-switch-buffer-size (:width 7))
              (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
              (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
              (ivy-rich-switch-buffer-project (:width 15 :face success))
              (ivy-rich-switch-buffer-path (:width 26)))
             :predicate (lambda (cand) (get-buffer cand))
             :delimiter "\t"))
          (function-trans
           '(:columns
             ((all-the-icons-ivy-rich-function-icon)
              (counsel-M-x-transformer (:width 50))
              (ivy-rich-counsel-function-docstring (:width 55 :face font-lock-doc-face)))))
          (variable-trans
           '(:columns
             ((all-the-icons-ivy-rich-variable-icon)
              (counsel-M-x-transformer (:width 50))
              (ivy-rich-counsel-function-docstring (:width 55 :face font-lock-doc-face)))))
          (recentf-trans
           '(:columns
             ((all-the-icons-ivy-rich-file-icon)
              (counsel-buffer-or-recentf-transformer))
             :delimiter "\t"))
          (bookmark-trans
           '(:columns
             ((ivy-rich-bookmark-type)
              (all-the-icons-ivy-rich-bookmark-name (:width 30))
              (ivy-rich-bookmark-info (:width 74)))
             :delimiter "	")))
      ;; switch-buffer
      (plist-put all-the-icons-ivy-rich-display-transformers-list
                 'ivy-switch-buffer switch-buffer-trans)
      (plist-put all-the-icons-ivy-rich-display-transformers-list
                 'ivy-switch-buffer-other-window switch-buffer-trans)
      (plist-put all-the-icons-ivy-rich-display-transformers-list
                 'counsel-switch-buffer switch-buffer-trans)
      (plist-put all-the-icons-ivy-rich-display-transformers-list
                 'counsel-switch-buffer-other-window switch-buffer-trans)
      ;; function icons
      (plist-put all-the-icons-ivy-rich-display-transformers-list
                 'counsel-M-x function-trans)
      (plist-put all-the-icons-ivy-rich-display-transformers-list
                 'counsel-describe-function function-trans)
      ;; variable icons
      (plist-put all-the-icons-ivy-rich-display-transformers-list
                 'counsel-describe-variable variable-trans)
      (plist-put all-the-icons-ivy-rich-display-transformers-list
                 'counsel-set-variable variable-trans)
      ;; recentf
      ;; TODO trancate long path string into one line
      (plist-put all-the-icons-ivy-rich-display-transformers-list
                 'counsel-recentf recentf-trans)
      (plist-put all-the-icons-ivy-rich-display-transformers-list
                 'counsel-buffer-or-recentf recentf-trans)
      ;; bookmark
      (plist-put all-the-icons-ivy-rich-display-transformers-list
                 'counsel-bookmark bookmark-trans))))

(defun my-ivy/init-ivy-posframe ()
  (use-package ivy-posframe
    :init
    (ivy-posframe-mode 1)

    :config
    (setq ivy-posframe-border-width 1)
    (setq ivy-posframe-width 110)
    (setq ivy-posframe-min-width 110)
    (setq ivy-posframe-min-height 10)
    (setq ivy-posframe-parameters
          '((left-fringe  . 5) (right-fringe . 5)))

    ;; Per command settings
    (setq ivy-posframe-display-functions-alist
          '((swiper . ivy-posframe-display-at-frame-bottom-window-center)
            (swiper-isearch . ivy-posframe-display-at-frame-bottom-window-center)
            (swiper-isearch-thing-at-point . ivy-posframe-display-at-frame-bottom-window-center)
            (counsel-rg . ivy-posframe-display-at-frame-bottom-window-center)
            (counsel-yank-pop . ivy-posframe-display-at-frame-bottom-window-center)
            (t . ivy-posframe-display-at-frame-center)))

    ;; Per command height settings
    (setq ivy-posframe-height-alist
          '((counsel-yank-pop . 15)
            (t . 10)))

    (set-face-attribute 'ivy-posframe nil :background "#282a36")
    (set-face-attribute 'ivy-posframe-border nil :background "#6272a4")
    (set-face-attribute 'ivy-posframe-cursor nil :background "#61bfff")))
