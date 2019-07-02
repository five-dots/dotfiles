;;------------------------------------------------------------------------------
;; Font settings
;; https://qiita.com/Duct-and-rice/items/ad77ab8b41b0cd83f1ec (文芸用エディタ)
;;------------------------------------------------------------------------------
(set-fontset-font nil 'japanese-jisx0213.2004-1
                  ;; (font-spec :family "Yu Mincho")
                  (font-spec :family "MeiryoKe_Console"))

(add-to-list 'face-font-rescale-alist '(".*Meiryo*." . 1.1))
(add-to-list 'face-font-rescale-alist '(".*Yu Mincho*." . 1.1))

;; Set proportional font
;; (set-face-attribute 'variable-pitch nil
;;                     :family "Yu Mincho"
;;                     :height 100)

;; (set-face-attribute 'fixed-pitch nil
;;                     :family "Consolas NF"
;;                     :height 100)

;; | 数字 | アルファベット | 日本語     |
;; | 1234 | abcdefghijklmn | こんにちは |

;;------------------------------------------------------------------------------
;; pangu-spacing
;; http://emacs.rubikitch.com/pangu-spacing/
;;------------------------------------------------------------------------------
(use-package pangu-spacing
  :init (global-pangu-spacing-mode 1))

;;------------------------------------------------------------------------------
;; migemo
;;------------------------------------------------------------------------------
(use-package migemo
  :if (eq system-type 'gnu/linux)
  :config
  (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
  :if (eq system-type 'windows-nt)
  :config
  (setq migemo-dictionary
        "c:/Users/shun/AppData/Local/cmigemo-default-win64/dict/utf-8/migemo-dict"))

;;------------------------------------------------------------------------------
;; DDSKK
;; http://quruli.ivory.ne.jp/document/ddskk_14.2/skk_toc.html#SEC_Contents
;;------------------------------------------------------------------------------
(use-package skk
  :disabled t
  :defer t
  :init (setq skk-tut-file "~/Dropbox/skk/SKK.tut")
  :config
  ;; (setq default-input-method "japanese-skk")
  ;; Henkan candidates
  (setq skk-show-inline t)
  ;; Cursor color
  (setq skk-use-color-cursor t)
  (setq skk-cursor-hiragana-color "yellow")
  (setq skk-cursor-katakana-color "blue violet")
  ;; Personal jisyo
  (setq skk-jisyo "~/Dropbox/skk/jisyo/skk-jisyo")
  (setq skk-backup-jisyo "~/Dropbox/skk/jisyo/skk-jisyo.bak")
  ;; Record file
  (setq skk-record-file "~/Dropbox/skk/record")
  ;; large jisyo
  (setq skk-large-jisyo "~/Dropbox/skk/jisyo/SKK-JISYO.L")
  ;; Extra jisyo
  (setq skk-extra-jisyo-file-list
        (list "~/Dropbox/skk/jisyo/SKK-JISYO.JIS2"
        '("~/Dropbox/skk/jisyo/SKK-JISYO.JIS3_4" . euc-jisx0213)
        "~/Dropbox/skk/jisyo/SKK-JISYO.assoc"
        "~/Dropbox/skk/jisyo/SKK-JISYO.notes"
        "~/Dropbox/skk/jisyo/SKK-JISYO.geo"
        "~/Dropbox/skk/jisyo/SKK-JISYO.hukugougo"
        "~/Dropbox/skk/jisyo/SKK-JISYO.jinmei"
        "~/Dropbox/skk/jisyo/SKK-JISYO.law"
        "~/Dropbox/skk/jisyo/SKK-JISYO.lisp"
        "~/Dropbox/skk/jisyo/SKK-JISYO.okinawa"
        "~/Dropbox/skk/jisyo/SKK-JISYO.propernoun"
        "~/Dropbox/skk/jisyo/SKK-JISYO.pubdic+"
        "~/Dropbox/skk/jisyo/SKK-JISYO.station"
        "~/Dropbox/skk/jisyo/SKK-JISYO.zipcode"
        "~/Dropbox/skk/jisyo/SKK-JISYO.office.zipcode"))
  ;; Enable latin mode at startup
  ;; http://slackwareirregulars.blogspot.com/2018/03/skk.html
  (let ((function #'(lambda () (skk-mode) (skk-latin-mode-on))))
    (dolist (hook '(org-mode-hook
                    find-file-hooks
                    minibuffer-setup-hook
                    mail-setup-hook
                    message-setup-hook))
      (add-hook hook function)))
  ;; Switch to latin mode when entering normal state
  ;; https://github.com/zarudama/dotfiles/blob/master/emacs/mikio/mikio-evil.el
  (defun my-skk-control ()
    (when skk-mode
      (skk-latin-mode 1)))
  (add-hook 'evil-normal-state-entry-hook 'my-skk-control))

;;------------------------------------------------------------------------------
;; Google translate
;;------------------------------------------------------------------------------
(use-package google-translate
  :init (setq google-translate-default-target-language "ja"))

;;------------------------------------------------------------------------------
;; Mozc
;;------------------------------------------------------------------------------
;;; mozc-im
;; (use-package mozc-im
;;   :init (setq default-input-method "japanese-mozc-im"))

;;; mozc-popup
;; (use-package mozc-popup
;;   :init (setq mozc-candidate-style 'popup))

;;; mozc-el-extensions
(add-to-list 'load-path "~/Dropbox/repos/github/iRi-E/mozc-el-extensions")
;; (use-package mozc-cursor-color)
;; (use-package mozc-isearch)
(use-package mozc-mode-line-indicator)

(use-package mozc
  :init
  (setq default-input-method "japanese-mozc")
  (setq mozc-candidate-style 'echo-area)
  ;; (defun activate-ime ()
  ;;   "Activate IME"
  ;;   (interactive)
  ;;   (unless current-input-method (toggle-input-method)))
  (defun toggle-ime ()
    "Toggle IME"
	  (interactive)
	  (toggle-input-method))
  (defun deactivate-ime ()
    "Deactivate IME"
    (interactive)
    (when current-input-method
      (evil-deactivate-input-method)
      (deactivate-input-method)))
  (bind-keys :map evil-insert-state-map
             ([muhenkan] . toggle-ime)
             ([henkan]   . deactivate-ime))
  ;; mozc.el で無変換キー/全角半角キーでちゃんと mozc-mode を切る
  ;; http://nos.hateblo.jp/entry/20120317/1331985029
  (defadvice mozc-handle-event (around intercept-keys (event))
    (if (member event (list 'zenkaku-hankaku 'henkan))
        (progn
          (mozc-clean-up-session)
          (toggle-input-method))
      (progn
        ; (message "%s" event) ; debug
        ad-do-it)))
  (ad-activate 'mozc-handle-event)
  ;; Disable IME w/o insert mode
  (add-hook 'evil-insert-state-exit-hook 'deactivate-ime))
