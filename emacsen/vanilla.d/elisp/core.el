;;; core

(use-package general
  :config
  (general-evil-setup)
  ;; leader wrappers
  (general-create-definer my/leader-def :prefix "SPC")
  (general-create-definer my/local-leader-def :prefix ","))

(use-package exec-path-from-shell
  :config
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize))

(use-package transient
  :config
  (setq transient-history-file
        (expand-file-name "transient/history.el" my/cache-dir)))

;; tramp
(progn
  (require 'tramp)
  (setq tramp-persistency-file-name
        (expand-file-name "tramp" my/cache-dir)))
