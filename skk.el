;;; skk configuration

;; inline candidates
(setq skk-show-inline t)

;; not new line by return
(setq skk-egg-like-newline t)

;; Cursor color
(setq skk-cursor-hiragana-color "yellow")
(setq skk-cursor-katakana-color "blue violet")

;; Record file
;; (setq skk-record-file "~/Dropbox/skk/skk-record")
(setq skk-record-file "~/.skk-record")

;; Personal jisyo
(setq skk-jisyo "~/Dropbox/skk/jisyo/skk-jisyo")
(setq skk-backup-jisyo "~/Dropbox/skk/jisyo/skk-jisyo.BAK")

;; large jisyo
;; (setq skk-large-jisyo "~/Dropbox/skk/jisyo/SKK-JISYO.L")
(setq skk-large-jisyo nil)

;; Extra jisyo
;; (setq skk-extra-jisyo-file-list
;;       '("~/Dropbox/skk/jisyo/SKK-JISYO.JIS2"
;;         '("~/Dropbox/skk/jisyo/SKK-JISYO.JIS3_4" . euc-jisx0213)
;;         "~/Dropbox/skk/jisyo/SKK-JISYO.assoc"
;;         "~/Dropbox/skk/jisyo/SKK-JISYO.notes"
;;         "~/Dropbox/skk/jisyo/SKK-JISYO.geo"
;;         "~/Dropbox/skk/jisyo/SKK-JISYO.hukugougo"
;;         "~/Dropbox/skk/jisyo/SKK-JISYO.jinmei"
;;         "~/Dropbox/skk/jisyo/SKK-JISYO.law"
;;         "~/Dropbox/skk/jisyo/SKK-JISYO.lisp"
;;         "~/Dropbox/skk/jisyo/SKK-JISYO.okinawa"
;;         "~/Dropbox/skk/jisyo/SKK-JISYO.propernoun"
;;         "~/Dropbox/skk/jisyo/SKK-JISYO.pubdic+"
;;         "~/Dropbox/skk/jisyo/SKK-JISYO.station"
;;         "~/Dropbox/skk/jisyo/SKK-JISYO.zipcode"
;;         "~/Dropbox/skk/jisyo/SKK-JISYO.office.zipcode"))

;; suppress message "saving skk jisyo ... done"
;; http://slackwareirregulars.blogspot.com/2018/03/skk.html
(defun skk-save-jisyo (&optional quiet)
  (interactive "P")
  (funcall skk-save-jisyo-function 'quiet))
