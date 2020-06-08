;;; lsp

(use-package lsp-mode
  :commands
  lsp

  :config
  (setq lsp-document-sync-method 'incremental) ; default nil
  (setq lsp-enable-completion-at-point nil) ; default t
  (setq lsp-prefer-flymake nil) ; flymake or lsp-ui
  (setq lsp-log-io nil)
  (setq lsp-session-file
        (expand-file-name "lsp-session" my/cache-dir)))

(use-package lsp-ui
  :preface
  (defun my/toggle-lsp-ui-doc ()
    (interactive)
    (if lsp-ui-doc-mode
        (progn
          (lsp-ui-doc-mode -1)
          (lsp-ui-doc--hide-frame))
      (lsp-ui-doc-mode 1)))

  :defer t

  :hook
  (lsp-mode . lsp-ui-mode)

  :config
  ;; lsp-ui-doc
  ;; (setq lsp-ui-doc-enable nil)
  ;; (setq lsp-ui-doc-header nil)
  ;; (setq lsp-ui-doc-include-signature nil)
  ;; (setq lsp-ui-doc-position 'at-point)
  ;; (setq lsp-ui-doc-max-width 150)
  ;; (setq lsp-ui-doc-max-height 30)
  ;; (setq lsp-ui-doc-use-childframe t)
  ;; (setq lsp-ui-doc-use-webkit nil)

  ;; lsp-ui-flycheck
  (setq lsp-ui-flycheck-enable t)

  ;; lsp-ui-peek
  ;; (setq lsp-ui-peek-enable t)
  ;; (setq lsp-ui-peek-peek-height 20)
  ;; (setq lsp-ui-peek-list-width 50)
  ;; (setq lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always

  ;; lsp-ui-imenu
  ;; (setq lsp-ui-imenu-enable nil)
  ;; (setq lsp-ui-imenu-kind-position 'top)

  ;; lsp-ui-sideline
  ;; (setq lsp-ui-sideline-enable nil)
  ;; (setq lsp-ui-sideline-enable nil)
  ;; (setq lsp-ui-sideline-ignore-duplicate t) ; nil
  ;; (setq lsp-ui-sideline-show-symbol t)
  ;; (setq lsp-ui-sideline-show-hover t) ; nil
  ;; (setq lsp-ui-sideline-show-diagnostics nil) ; t
  ;; (setq lsp-ui-sideline-show-code-actions nil) ;t
  ;; (setq lsp-ui-sideline-code-actions-prefix "")
  )

(use-package lsp-python-ms
  :hook
  (python-mode . (lambda () (require 'lsp-python-ms) (lsp)))

  :config
  (setq lsp-python-ms-python-executable-cmd "python3") ; default python
  (setq lsp-python-ms-dir
        (expand-file-name "~/Dropbox/repos/github/Miscrosoft/python-language-server/output/bin/Release/"))
  (setq lsp-python-ms-executable
        (expand-file-name
         "linux-x64/publish/Microsoft.Python.LanguageServer" lsp-python-ms-dir)))

(use-package ccls
  :hook
  (c++-mode . (lambda () (require 'ccls) (lsp)))

  :config
  (setq ccls-sem-highlight-method 'font-lock) ; nil, font-lock or overlay (slower)
  (setq ccls-executable "/usr/local/bin/ccls")
  (setq c-c++-lsp-cache-dir
        (expand-file-name "lsp-ccls" my/cache-dir)))

(use-package company-lsp
  :after
  (lsp-mode company)

  :config
  (setq company-lsp-cache-candidates t)
  (setq company-lsp-async t)
  (setq company-lsp-enable-recompletion nil))

(use-package dap-ui
  :straight nil
  :load-path "straight/build/dap-mode"
  :hook (dap-mode . dap-ui-mode))

(use-package dap-mode
  :defer t

  :hook
  (lsp-mode . dap-mode)

  :config
  (setq dap-gdb-lldb-path
		(expand-file-name ".extension/vscode/webfreak.debug" my/cache-dir))
  (setq dap-breakpoints-file
        (expand-file-name "dap-breakpoints" my/cache-dir)))

(use-package dap-python
  :straight nil
  :load-path "straight/build/dap-mode"
  :config
  (setq dap-python-executable "python3"))

(use-package dap-gdb-lldb
  :straight nil
  :load-path "straight/build/dap-mode")
