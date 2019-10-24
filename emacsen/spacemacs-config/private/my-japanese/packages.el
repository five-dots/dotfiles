;;; packages.el --- my-japanese layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: shun <shun@desk1>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst my-japanese-packages
  '(
    ddskk
    pangu-spacing
    mozc
    ))

(defun my-japanese/init-ddskk ()
  (use-package ddskk
    :disabled t
    :defer t
    :hook
    ;; Always start using latin mode
    (evil-insert-state-entry . skk-mode)
    ;; Disable skk mode when entering normal state
    (evil-normal-state-entry . (lambda () (skk-mode -1)))
    (skk-mode . skk-latin-mode-on)

    :init
    (setq default-input-method "japanese-skk")
    ;; 変換モードで確定をしても改行されない
    (setq skk-egg-like-newline t)
    ;; Henkan candidates
    (setq skk-show-inline t)
    ;; Cursor color
    (setq skk-cursor-hiragana-color "yellow")
    (setq skk-cursor-katakana-color "blue violet")
    ;; Record file
    (setq skk-record-file "~/Dropbox/skk/record")

    ;;; Jisyo
    (setq skk-save-jisyo-instantly t)
    ;; Personal jisyo
    (setq skk-jisyo "~/Dropbox/skk/jisyo/skk-jisyo")
    (setq skk-backup-jisyo "~/Dropbox/skk/jisyo/skk-jisyo.bak")
    ;; large jisyo
    (setq skk-large-jisyo "~/Dropbox/skk/jisyo/SKK-JISYO.L")
    ;; Extra jisyo
    ;; (setq skk-extra-jisyo-file-list
    ;;       (list "~/Dropbox/skk/jisyo/SKK-JISYO.JIS2"
    ;;             '("~/Dropbox/skk/jisyo/SKK-JISYO.JIS3_4" . euc-jisx0213)
    ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.assoc"
    ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.notes"
    ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.geo"
    ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.hukugougo"
    ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.jinmei"
    ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.law"
    ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.lisp"
    ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.okinawa"
    ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.propernoun"
    ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.pubdic+"
    ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.station"
    ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.zipcode"
    ;;             "~/Dropbox/skk/jisyo/SKK-JISYO.office.zipcode"))
    ;; saving skk jisyo ... done というメッセージが表示されるのを省略
    ;; http://slackwareirregulars.blogspot.com/2018/03/skk.html
    ;; FIXME saving skk jisyo ... が引き続き表示されてしまう
    (defun skk-save-jisyo (&optional quiet)
      (interactive "P")
      (funcall skk-save-jisyo-function 'quiet))

    :config
    ;; TODO 現在の skk mode に応じて [muhenkan] key で
    ;; latin <-> hiragana を切り替える関数
    (bind-keys :map skk-latin-mode-map
               ([muhenkan] . skk-kakutei))))

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
    :config
    (bind-keys
     :map evil-insert-state-map
     ;; ([henkan] . my/deactivate-ime)
     ([muhenkan] . my/toggle-ime))
    (setq mozc-candidate-style 'echo-area)
    ;; mozc.el で無変換キー/全角半角キーでちゃんと mozc-mode を切る
    ;; http://nos.hateblo.jp/entry/20120317/1331985029
    (defadvice mozc-handle-event (around intercept-keys (event))
      (if (member event (list 'zenkaku-hankaku 'henkan))
          (progn
            (mozc-clean-up-session)
            (toggle-input-method))
        (progn
          ;; (message "%s" event) ; debug
          ad-do-it)))
    (ad-activate 'mozc-handle-event)
    ;; Disable IME w/o insert mode
    (add-hook 'evil-insert-state-exit-hook 'my/deactivate-ime)))
