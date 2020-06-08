;;; eshell

(use-package eshell
  :config
  (setq eshell-directory-name
		(expand-file-name "eshell" my/cache-dir)))
