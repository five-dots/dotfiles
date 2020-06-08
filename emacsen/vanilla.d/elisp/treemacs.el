;;; treemacs

(use-package treemacs
  ;; https://github.com/Alexander-Miller/treemacs

  :defer t

  :after (:all evil counsel)

  :config
  (setq treemacs-position 'right)
  (setq treemacs-lock-width t)
  (treemacs-resize-icons 16) ; default 22
  ;; Turn off follow-mode "permanently" in Spacemacs #500
  ;; https://github.com/Alexander-Miller/treemacs/issues/500
  (treemacs-follow-mode -1))

(use-package treemacs-evil
  :after (treemacs evil))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package treemacs-icons-dired
  :after (treemacs dired)

  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package treemacs-persp
  :after (treemacs persp-mode)
  :config (treemacs-set-scope-type 'Perspectives))
