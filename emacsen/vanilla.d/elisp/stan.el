;;; stan

(use-package stan-mode
  :mode
  ("\\.stan\\'" . stan-mode)

  :hook
  (stan-mode . stan-mode-setup)

  :config
  (setq stan-indentation-offset 2)
  ;; Add snippets dir
  ;; (add-to-list
  ;;  'yas-snippet-dirs
  ;;  (expand-file-name
  ;;   "straight/repos/stan-mode/stan-snippets/snippets"
  ;;   user-emacs-directory))
  )

(use-package company-stan :disabled
  :hook (stan-mode . company-stan-setup)
  :config
  (setq company-stan-fuzzy nil))

(use-package flycheck-stan :disabled t
  :hook (stan-mode . flycheck-stan-setup))

(use-package eldoc-stan :disabled t
  :hook (stan-mode . eldoc-stan-setup))

(use-package stan-snippets :disabled t
  :hook (stan-mode . stan-snippets-initialize))
