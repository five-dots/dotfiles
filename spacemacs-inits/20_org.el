;;------------------------------------------------------------------------------
;; org-agenda
;;------------------------------------------------------------------------------

;; (use-package org-agenda
;;   :config
;;   (setq org-agenda-files '("~/Dropbox/org/wiki")))

;;------------------------------------------------------------------------------
;; org
;;------------------------------------------------------------------------------
(use-package org
  :config
  (setq org-hide-emphasis-markers t)
  ;; babel related
  (setq org-confirm-babel-evaluate nil)
  (setq org-src-tab-acts-natively nil)
  (setq org-preview-latex-image-directory "~/Dropbox/memo/img/latex/")
  ;; Enlarge inline formula preview
  (plist-put org-format-latex-options :scale 1.5)
  ;; Replace "-" with "•"
  (font-lock-add-keywords
   'org-mode
   '(("^ *\\([-]\\) "
      (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  ;; Custom function to get ramdom file name
  (cl-defun get-babel-file (&key
                            (dir "~/Dropbox/memo/img/babel/")
                            (prefix "fig-")
                            (suffix ".png"))
    (concat dir (make-temp-name prefix) suffix)))

;; Change font size by levels
;; (custom-set-faces
;;  '(org-level-1 ((t (:inherit outline-1 :height 1.35))))
;;  '(org-level-2 ((t (:inherit outline-2 :height 1.3))))
;;  '(org-level-3 ((t (:inherit outline-3 :height 1.25))))
;;  '(org-level-4 ((t (:inherit outline-4 :height 1.0)))))

;;------------------------------------------------------------------------------
;; org-bullets
;;------------------------------------------------------------------------------
(use-package org-bullets
  :config
  (setq org-bullets-bullet-list '("" "" "" "" "" "" "" "" "")))

;;------------------------------------------------------------------------------
;; org-babel-eval-in-repl
;;------------------------------------------------------------------------------
;; (use-package org-babel-eval-in-repl
;;   :init
;;   (bind-keys :map org-mode-map ("C-<return>" . ober-eval-in-repl)))

;;------------------------------------------------------------------------------
;; ox-hugo
;;------------------------------------------------------------------------------

(use-package ox-hugo
  ;; (setq org-hugo-default-section-directory "posts")
  )

;;------------------------------------------------------------------------------
;; Beautifiying Org Mode
;; https://zzamboni.org/post/beautifying-org-mode-in-emacs/
;;------------------------------------------------------------------------------
;; Variable fonts
;; (let* ((variable-tuple
;;         (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
;;               ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
;;               (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
;;        (base-font-color     (face-foreground 'default nil 'default))
;;        (headline           `(:inherit default :weight bold :foreground ,base-font-color)))
;;   (custom-theme-set-faces
;;    'user
;;    `(org-level-8 ((t (,@headline ,@variable-tuple))))
;;    `(org-level-7 ((t (,@headline ,@variable-tuple))))
;;    `(org-level-6 ((t (,@headline ,@variable-tuple))))
;;    `(org-level-5 ((t (,@headline ,@variable-tuple))))
;;    `(org-level-4 ((t (,@headline ,@variable-tuple))))
;;    `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.1))))
;;    `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.25))))
;;    `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.5))))
;;    `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))

;; Variable and fixed pitch faces
;; (custom-theme-set-faces
;;  'user
;;  '(variable-pitch ((t (:family "Source Sans Pro" :height 180 :weight light))))
;;  '(fixed-pitch ((t ( :family "Consolas" :slant normal :weight normal :height 1.0 :width normal)))))

;; (custom-theme-set-faces
;;  'user
;;  '(variable-pitch ((t (:family "Source Sans Pro"))))
;;  '(fixed-pitch ((t ( :family "Consolas NF")))))
;; (add-hook 'org-mode-hook 'variable-pitch-mode)

;; Visual line mode for long lines
(add-hook 'org-mode-hook 'visual-line-mode)

;; Configure faces for specific Org elements
;; (custom-theme-set-faces
;;  'user
;;  '(org-block                 ((t (:inherit fixed-pitch))))
;;  '(org-document-info         ((t (:foreground "dark orange"))))
;;  '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
;;  '(org-link                  ((t (:foreground "royal blue" :underline t))))
;;  '(org-meta-line             ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;  '(org-property-value        ((t (:inherit fixed-pitch))) t)
;;  '(org-special-keyword       ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;  '(org-tag                   ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
;;  '(org-verbatim              ((t (:inherit (shadow fixed-pitch))))))

;; (custom-theme-set-faces
;;  'user
;;  '(org-block                 ((t (:inherit fixed-pitch))))
;;  '(org-document-info         ((t (:inherit fixed-pitch))))
;;  '(org-document-info-keyword ((t (:inherit fixed-pitch))))
;;  '(org-link                  ((t (:inherit fixed-pitch))))
;;  '(org-meta-line             ((t (:inherit fixed-pitch))))
;;  '(org-property-value        ((t (:inherit fixed-pitch))))
;;  '(org-special-keyword       ((t (:inherit fixed-pitch))))
;;  '(org-tag                   ((t (:inherit fixed-pitch))))
;;  '(org-table                 ((t (:inherit fixed-pitch))))
;;  '(org-verbatim              ((t (:inherit fixed-pitch)))))

;;------------------------------------------------------------------------------
;; Font
;;------------------------------------------------------------------------------

;; (require 'org-variable-pitch)
;; (add-hook 'org-mode-hook 'org-variable-pitch-minor-mode)

;; https://www.reddit.com/r/emacs/comments/66w75c/monospace_font_for_calendar_in_orgmode/
;; FONTS
;; -----
;; Set variable-pitch font using customize-face variable-pitch
;; Set the fonts to format correctly for specific modes. Default is set for fixed
;; so we only need to have the exceptions

;; (defun set-buffer-variable-pitch ()
;;   (interactive)
;;   (variable-pitch-mode t)
;;   (setq line-spacing 3)
;;   (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
;;   (set-face-attribute 'org-link nil :inherit 'fixed-pitch)
;;   (set-face-attribute 'org-code nil :inherit 'fixed-pitch)
;;   (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
;;   (set-face-attribute 'org-date nil :inherit 'fixed-pitch)
;;   (set-face-attribute 'org-special-keyword nil :inherit 'fixed-pitch))

;; (add-hook 'org-mode-hook 'set-buffer-variable-pitch)
;; (add-hook 'markdown-mode-hook 'set-buffer-variable-pitch)
;; (add-hook 'Info-mode-hook 'set-buffer-variable-pitch)
