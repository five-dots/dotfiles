;;; ivy

;; (use-package ivy-hydra)
;; (use-package ivy-yasnippet)
;; (use-package ivy-xref)
;; (use-package counsel-osx-app)
;; (use-package counsel-world-clock)
;; (use-package counsel-tramp)
;; (use-package wgrep)
;; (use-package flx)

(use-package ivy-prescient
  :after
  (prescient)

  :hook
  (ivy-mode . ivy-prescient-mode)
  (ivy-prescient-mode . prescient-persist-mode))

(use-package ivy-posframe
  :hook
  (ivy-mode . ivy-posframe-mode)

  :config
  (setq ivy-posframe-border-width 1)
  (setq ivy-posframe-width 110)
  (setq ivy-posframe-min-width 110)
  (setq ivy-posframe-min-height 10)
  (setq ivy-posframe-height 10)
  (setq ivy-posframe-parameters '((left-fringe . 5) (right-fringe . 5)))

  ;; Per command settings
  (setq ivy-posframe-display-functions-alist
        '((swiper . ivy-display-function-fallback)
          (swiper-all . ivy-display-function-fallback)
          (counsel-rg . ivy-display-function-fallback)
          (counsel-yank-pop . ivy-display-function-fallback)
          (t . ivy-posframe-display-at-frame-center)))

  ;; Per command height settings
  (setq ivy-posframe-height-alist
        '((swiper . 20)
          (swiper-all . 20)
          (counsel-rg . 20)
          (counsel-yank-pop . 20)
          (t . 10)))

  ;; See ivy-posframe-parameters
  :custom-face
  (ivy-posframe ((t (:background "#282a36"))))
  (ivy-posframe-border ((t (:background "#6272a4"))))
  (ivy-posframe-cursor ((t (:background "#61bfff")))))

(use-package ivy-rich
  ;; More friendly display transformer for Ivy
  ;; https://github.com/Yevgnen/ivy-rich

  :hook
  (counsel-projectile-mode . ivy-rich-mode) ; Must load after `counsel-projectile'
  (ivy-rich-mode . (lambda ()
                     "Use abbreviate in `ivy-rich-mode'."
                     (setq ivy-virtual-abbreviate
                           (or (and ivy-rich-mode 'abbreviate) 'name))))

  :init
  (setq ivy-rich-path-style 'relative) ; relative, full or abbrev
  ;; Improve performance by disabling tramp files info
  (setq ivy-rich-parse-remote-buffer nil))

(use-package all-the-icons-ivy :disabled t
  ;; Ivy/Counsel integration for all-the-icons.el
  ;; https://github.com/asok/all-the-icons-ivy

  :config
  (all-the-icons-ivy-setup))

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
            (ivy-rich-counsel-function-docstring (:width 54 :face font-lock-doc-face)))))
        (variable-trans
         '(:columns
           ((all-the-icons-ivy-rich-variable-icon)
            (counsel-M-x-transformer (:width 50))
            (ivy-rich-counsel-function-docstring (:width 54 :face font-lock-doc-face)))))
        (recentf-trans
         '(:columns
           ((all-the-icons-ivy-rich-file-icon)
            (counsel-buffer-or-recentf-transformer))
           :delimiter "\t")))
    ;; switch-buffer
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'ivy-switch-buffer switch-buffer-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'ivy-switch-buffer-other-window switch-buffer-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-switch-buffer switch-buffer-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-switch-buffer-other-window switch-buffer-trans)
    ;; describe
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-M-x function-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-describe-function function-trans)
    ;; describe
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-describe-variable variable-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-set-variable variable-trans)
    ;; recentf
    ;; TODO trancate long path string into one line
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-recentf recentf-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-buffer-or-recentf recentf-trans)))

(use-package counsel-projectile
  :hook
  (counsel-mode . counsel-projectile-mode))

(use-package counsel
  :hook
  (ivy-mode . counsel-mode) ; replace common emacs commands with counsel's

  :config
  (add-to-list 'ivy-height-alist '(counsel-yank-pop . 15))
  (setq counsel-yank-pop-separator "\n--------------------\n"))

(use-package ivy
  :hook
  (after-init . ivy-mode) ; set completing-read-function use ivy

  :config
  (setq ivy-height 10) ; default 10

  ;; recommended configuration for ivy-rich
  ;; (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)

  (setq ivy-use-virtual-buffers t))

(use-package amx
  ;; Alternative M-x
  ;; - Prioritize most used commands
  ;; - Showing keyboard shortcuts
  ;; https://github.com/DarwinAwardWinner/amx

  :config
  (setq amx-save-file
        (expand-file-name "amx-items" my/cache-dir)))
