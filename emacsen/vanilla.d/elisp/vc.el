;;; version control

(use-package vc
  :config
  (setq vc-follow-symlinks t))

(use-package magit)

(use-package magit-todos
  :after magit)

;; forge
;; magit-gitflow
;; github-review
;; evil-magit
