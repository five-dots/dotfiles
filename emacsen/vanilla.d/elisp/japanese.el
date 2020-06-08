;;; japanese

(use-package ddskk
  ;; https://github.com/skk-dev/ddskk/blob/master/READMEs/INSTALL.MELPA.md
  ;; see ~/.skk for more configurations

  :hook
  ;; Always start with latin mode
  (evil-insert-state-entry . skk-mode)
  (skk-mode . skk-latin-mode-on)

  ;; Disable skk mode when exiting insert state
  (evil-insert-state-exit . (lambda () (when skk-mode (skk-mode -1))))

  :init
  (setq default-input-method "japanese-skk"))

;; TODO migemo for mac

(use-package pangu-spacing
  :init
  (setq pangu-spacing-chinese-before-english-regexp
        (rx (group-n 1 (category japanese))
            (group-n 2 (in "a-zA-Z0-9"))))
  (setq pangu-spacing-chinese-after-english-regexp
        (rx (group-n 1 (in "a-zA-Z0-9"))
            (group-n 2 (category japanese))))
  (setq pangu-spacing-real-insert-separtor t)
  (global-pangu-spacing-mode 1))

(use-package google-translate
  :defer t

  :config
  (setq google-translate-pop-up-buffer-set-focus t)
  (setq google-translate-default-source-language "en")
  (setq google-translate-default-target-language "ja"))

(use-package evil-tutor-ja
  :defer t

  :config
  (setq evil-tutor-ja-working-directory
        (expand-file-name "tutor-ja" my/cache-dir)))

(use-package migemo
  :if (executable-find "cmigemo")

  :config
  (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-directory "/usr/share/cmigemo/utf-8/migemo-dict")
  (setq migemo-coding-system 'utf-8-unix)
  (migemo-init))

(use-package mozc :disabled
  :init
  (setq default-input-method "japanese-mozc")

  :hook
  (evil-insert-state-exit . my/deactivate-ime)

  :general
  ('evil-insert-state-map
   [muhenkan] #'toggle-input-method)

  :config
  ;; (bind-keys
  ;;  :map evil-insert-state-map
  ;;  ([muhenkan] . toggle-input-method))

  (setq mozc-candidate-style 'echo-area)

  ;; Disable mozc-mode properly by [muhenkan]/[zenkaku-hankaku]
  ;; http://nos.hateblo.jp/entry/20120317/1331985029
  (defadvice mozc-handle-event (around intercept-keys (event))
    (if (member event (list 'zenkaku-hankaku 'henkan))
        (progn
          (mozc-clean-up-session)
          (toggle-input-method))
      (progn
        ;; (message "%s" event) ; debug
        ad-do-it)))
  (ad-activate 'mozc-handle-event))

(use-package mozc-im :disabled t
  :after mozc

  :config
  (setq default-input-method "japanese-mozc-im"))

(use-package mozc-popup :disabled t
  :after mozc

  :config
  (setq mozc-candidate-style 'popup))

(use-package mozc-mode-line-indicator :disabled t
  :after mozc
  :straight nil
  :load-path "~/Dropbox/repos/github/iRi-E/mozc-el-extensions")

(use-package mozc-isearch :disabled t
  :after mozc
  :straight nil
  :load-path "~/Dropbox/repos/github/iRi-E/mozc-el-extensions")

(use-package mozc-cand-posframe :disabled t
  :after mozc
  :config
  (setq mozc-candidate-style 'posframe))
