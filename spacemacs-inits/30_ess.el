;;------------------------------------------------------------------------------
;; ess
;;------------------------------------------------------------------------------
;;; Comment
;; (setq ess-indent-with-fancy-comments nil)
;; (make-variable-buffer-local 'comment-add)
;; (setq comment-add 0)

;;; Other settings
;; (setq ess-ask-about-transfile nil)
;; (setq ess-ask-for-ess-directory nil)
;; (setq inferior-R-args "")

(use-package ess-site
  :init
  ;; Show help at echo area
  (setq ess-eldoc-show-on-symbol t)
  ;; Don't save history
  (setq ess-history-file nil)
  ;; Diable unnecessary completion settings
  (setq ess-use-R-completion nil)
  (setq ess-use-auto-complete nil)
  (setq ess-use-ido nil)
  ;; ess-R-object-popup
  (add-to-list 'load-path "~/Dropbox/repos/github/myuhe/ess-R-object-popup.el")
  (use-package ess-R-object-popup)
  ;; Keymap for ess-r-mode
  (spacemacs/set-leader-keys-for-major-mode 'ess-r-mode
    "."   'ess-R-object-popup
    ;; "SPC" 'ess-view-inspect-df
    ;; "" 'ess-describe-object-at-point
    ;; "" 'ess-r-set-evaluation-env
    )
  ;; Keymap for inferior-ess-r-mode
  (spacemacs/set-leader-keys-for-major-mode 'inferior-ess-r-mode
    "v" 'ess-view-inspect-df
    "l" 'comint-clear-buffer
    "r" 'inferior-ess-reload)
  :hook
  ;; Enable company for iESS
  (inferior-ess-r-mode . company-mode))

;;------------------------------------------------------------------------------
;; ess-view
;;------------------------------------------------------------------------------
(use-package ess-view
  ;; Linux
  :if (eq system-type 'gnu/linux)
  :init
  (setq ess-view--spreadsheet-program "/usr/bin/gnumeric")
  ;; Windows
  :if (eq system-type 'windows-nt)
  :init
  (setq ess-view--spreadsheet-program
        "c:/Program Files (x86)/Microsoft Office/root/Office16/EXCEL.EXE"))

;;------------------------------------------------------------------------------
;; inlineR
;;------------------------------------------------------------------------------
(add-to-list 'load-path "~/Dropbox/repos/github/myuhe/inlineR.el")
(use-package inlineR)

;;------------------------------------------------------------------------------
;; e2wm-R
;;------------------------------------------------------------------------------
;; e2wm-R
;; (defun e2wm:toggle-management ()
;;   (interactive)
;;   (if (e2uwm:pst-get-instance)
;;       (e2wm:stop-management) (e2wm:dp-R-view)))

;;------------------------------------------------------------------------------
;; ess keymap
;;------------------------------------------------------------------------------
(defun insert_R_assign ()
  "Insert <-"
  (interactive)
  (just-one-space 1)
  (insert "<-")
  (just-one-space 1))

(defun insert_R_pipe ()
  "Insert %>%"
  (interactive)
  (just-one-space 1)
  (insert "%>%")
  (reindent-then-newline-and-indent))

;; https://emacs.stackexchange.com/questions/28105/how-to-define-bindings-for-multiple-keymaps-with-bind-keys
(dolist (m (list ess-r-mode-map inferior-ess-r-mode-map org-mode-map))
  (bind-keys :map m
             ("C-=" . insert_R_assign)
             ("C->" . insert_R_pipe)))
