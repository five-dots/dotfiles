;;; snippet

(use-package yasnippet
  :hook
  (after-init . yas-global-mode)

  :config
  (use-package yasnippet-snippets)
  (add-to-list 'yas-snippet-dirs my/snippets-dir))
