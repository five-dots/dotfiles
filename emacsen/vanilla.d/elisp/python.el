;;; python

(use-package python
  :config
  ;; Can’t guess python-indent-offset, using defaults: 4... のメッセージを表示しない
  (setq python-indent-guess-indent-offset-verbose nil)

  ;; https://github.com/jorgenschaefer/elpy/issues/733
  ;; (setq python-shell-prompt-detect-enabled nil)
  ;; (setq python-shell-prompt-detect-failure-warning nil)

  ;; (add-to-list 'python-shell-completion-native-disabled-interpreters "python3")

  (setq python-shell-interpreter "ipython3") ; "python3" or "ipython3"
  (setq org-babel-python-command "python3"))

(use-package anaconda-mode :disabled
  :defer t

  :hook
  (python-mode . anaconda-mode)
  (python-mode . anaconda-eldoc-mode)

  :config
  (setq anaconda-mode-installation-directory
        (expand-file-name "anaconda-mode" my/cache-dir)))

(use-package company-anaconda :disabled
  :defer t
  :after company)

(use-package jupyter :disabled t
  :after (org)

  :config
  ;; use ob-jupyter as default python of org-babel
  ;; (org-babel-jupyter-override-src-block "python"))
  (setq org-babel-default-header-args:jupyter-python
        '((:kernel . "python3"))))

(use-package ein
  :disabled t

  :config
  (setq ob-ein-inline-image-directory
        (expand-file-name "~/Dropbox/memo/img/babel-ein/")))

(use-package ob-ipython :disabled t)
