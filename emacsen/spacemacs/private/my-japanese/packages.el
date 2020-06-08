;;; packages.el --- my-japanese layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Shun Asai <syun.asai@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst my-japanese-packages
  '(
    ddskk
    pangu-spacing

    ;; mozc
    mozc
    mozc-im
    mozc-popup
    mozc-cand-posframe
    (mozc-mode-line-indicator
     :location (recipe :fetcher github :repo "iRi-E/mozc-el-extensions"))
    (mozc-isearch
     :location (recipe :fetcher github :repo "iRi-E/mozc-el-extensions"))

    japanese-holidays
    ))

(defun my-japanese/init-ddskk ()
  (use-package ddskk
    ;; see ~/.skk for more configurations
    :disabled

    :hook
    ;; Always start with latin mode
    (evil-insert-state-entry . skk-mode)
    (skk-mode . skk-latin-mode-on)

    ;; Disable skk mode when exiting insert state
    (evil-insert-state-exit . (lambda () (when skk-mode (skk-mode -1))))

    :init
    (setq default-input-method "japanese-skk")))

(defun my-japanese/init-pangu-spacing ()
  (use-package pangu-spacing
    :init
    (setq pangu-spacing-chinese-before-english-regexp
          (rx (group-n 1 (category japanese))
              (group-n 2 (in "a-zA-Z0-9"))))
    (setq pangu-spacing-chinese-after-english-regexp
          (rx (group-n 1 (in "a-zA-Z0-9"))
              (group-n 2 (category japanese))))
    (setq pangu-spacing-real-insert-separtor t)
    (global-pangu-spacing-mode 1)))

(defun my-japanese/init-mozc ()
  (use-package mozc
    :init
    (setq default-input-method "japanese-mozc")

    :hook
    (evil-insert-state-exit . my/deactivate-ime)

    :config
    (evil-define-key 'insert global-map
      [henkan] 'toggle-input-method)

    (setq mozc-candidate-style 'echo-area)

    ;; Disable mozc-mode properly by [henkan], [muhenkan] and [zenkaku-hankaku]
    ;; http://nos.hateblo.jp/entry/20120317/1331985029
    (defadvice my/mozc-handle-event (around intercept-keys (event))
      (if (member event (list 'henkan 'muhenkan 'zenkaku-hankaku ))
          (progn
            (mozc-clean-up-session)
            (toggle-input-method))
        (progn
          ;; (message "%s" event) ; debug
          ad-do-it)))
    (ad-activate 'my/mozc-handle-event)))

(defun my-japanese/init-mozc-im ()
  (use-package mozc-im
    :disabled
    :after mozc
    :config
    (setq default-input-method "japanese-mozc-im")))

(defun my-japanese/init-mozc-popup ()
  (use-package mozc-popup
    :disabled
    :after mozc
    :config
    (setq mozc-candidate-style 'popup)))

(defun my-japanese/init-mozc-mode-line-indicator ()
  (use-package mozc-mode-line-indicator
    :disabled
    ))

(defun my-japanese/init-mozc-isearch ()
  (use-package mozc-isearch
    :disabled))

(defun my-japanese/init-mozc-cand-posframe ()
  (use-package mozc-cand-posframe
    :disabled
    :after mozc
    :config
    (setq mozc-candidate-style 'posframe)
    ;; face
    (set-face-attribute 'mozc-cand-posframe-normal-face nil
                        :background "#23272e"
                        :foreground "#bbc2cf")
    (set-face-attribute 'mozc-cand-posframe-focused-face nil
                        :background "#2257A0"
                        :foreground "#bbc2cf"
                        :weight 'bold)
    (set-face-attribute 'mozc-cand-posframe-footer-face nil
                        :foreground "#bbc2cf")))

(defun my-japanese/init-japanese-holidays ()
  (use-package japanese-holidays
    :after calendar
    :config
    (setq calendar-holidays
          (append japanese-holidays holiday-local-holidays holiday-other-holidays))
    (setq mark-holidays-in-calendar t)
    (setq japanese-holiday-weekend '(0 6)
          japanese-holiday-weekend-marker
          '(holiday nil nil nil nil nil japanese-holiday-saturday))
    (add-hook 'calendar-today-visible-hook 'japanese-holiday-mark-weekend)
    (add-hook 'calendar-today-invisible-hook 'japanese-holiday-mark-weekend)
    (add-hook 'calendar-today-visible-hook 'calendar-mark-today)))
