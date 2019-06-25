;;------------------------------------------------------------------------------
;; Misc
;;------------------------------------------------------------------------------

;; Evil escape delay
(use-package evil-escape
  :config
  (setq evil-escape-delay 0.2))

;; exec-path-from-shell
;; https://qiita.com/catatsuy/items/3dda714f4c60c435bb25
;; (when (eq system-type 'gnu/linux)
;;   (exec-path-from-shell-initialize))

;; completion ignore case
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

;; Frame size
(set-frame-size (selected-frame) 130 60)

;; Trancate line
;; (setq-default truncate-lines t)

;; カーソルのちらつきを抑える
;; https://blog.pluser.net/posts/2018/emacs-double-buffering-flickering/
;; (set-frame-parameter nil 'inhibit-double-buffering t)
;; http://hylom.net/emacs-25.1-ime-flicker-problem
(setq redisplay-dont-pause nil)

;;------------------------------------------------------------------------------
;; Evil keymap
;;------------------------------------------------------------------------------

(dolist (m (list evil-normal-state-map evil-visual-state-map))
  (bind-keys :map m
             ("H"  . evil-first-non-blank-of-visual-line)
             ("J"  . evil-forward-paragraph)
             ("K"  . evil-backward-paragraph)
             ("L"  . evil-end-of-visual-line)
             ("j"  . evil-next-visual-line)
             ("k"  . evil-previous-visual-line)
             ("gj" . evil-next-line)
             ("gk" . evil-previous-line)))

(bind-keys :map evil-insert-state-map
           ("C-," . company-manual-begin))

;; Return & Shift-Return
;; nnoremap <CR> A<CR><ESC>
;; nnoremap <S-CR> O<ESC>D

;;------------------------------------------------------------------------------
;; treemacs
;;------------------------------------------------------------------------------
(use-package treemacs
  :init
  (setq treemacs-position 'right))

;;------------------------------------------------------------------------------
;; highlight-indent-guides
;;------------------------------------------------------------------------------
(use-package highlight-indent-guides
  :config
  (setq highlight-indent-guides-method 'character)
  ;; :hook
  ;; (ess-r-mode . highlight-indent-guides-mode)
  ;; (csharp-mode . highlight-indent-guides-mode)
  )

;;------------------------------------------------------------------------------
;; Origami
;;------------------------------------------------------------------------------
(use-package origami
  :init
  (evil-add-to-alist 'origami-parser-alist 'ess-r-mode 'origami-c-parser)
  (evil-add-to-alist 'origami-parser-alist 'csharp-mode 'origami-c-style-parser))

;;------------------------------------------------------------------------------
;; lispxmp
;;------------------------------------------------------------------------------
(use-package lispxmp
  :init
  (spacemacs/set-leader-keys-for-major-mode 'emacs-lisp-mode
    "ex" 'lispxmp)
  (spacemacs/set-leader-keys-for-major-mode 'lisp-interaction-mode
    "ex" 'lispxmp))

;;------------------------------------------------------------------------------
;; ivy-postframe
;;------------------------------------------------------------------------------
;; (use-package ivy-posframe
;;   :config
;;   (setq ivy-posframe-parameters '((left-fringe . 5) (right-fringe . 5)))
;;   (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
;;   (setq ivy-posframe-width 110)
;;   (setq ivy-posframe-height 13)
;;   (ivy-posframe-mode)
;;   :custom-face
;;   (ivy-posframe ((t (:background "#282a36"))))
;;   (ivy-posframe-border ((t (:background "#6272a4"))))
;;   (ivy-posframe-cursor ((t (:background "#61bfff")))))

;;------------------------------------------------------------------------------
;; helm-postframe
;;------------------------------------------------------------------------------
(use-package helm-posframe
  :config
  ;; (setq helm-posframe-parameters '((left-fringe . 5) (right-fringe . 5)))
  (setq helm-posframe-parameters
        '(;; (left-fringe . 5)
          ;; (right-fringe . 5)
          ;; (internal-border-width . 2)
          ;; (internal-border-color . "#6272a4")
          (background-color . "#282a36")))
  (setq helm-posframe-poshandler 'posframe-poshandler-frame-center)
  (setq helm-posframe-width 120)
  (setq helm-posframe-height 13)
  (helm-posframe-enable))

;;------------------------------------------------------------------------------
;; which-key-posframe
;;------------------------------------------------------------------------------
;; (use-package which-key-posframe
;;   :config
;;   (setq which-key-posframe-poshandler 'posframe-poshandler-frame-center)
;;   (setq which-key-posframe-border-width 1)
;;   (setq which-key-posframe-width 120)
;;   (which-key-posframe-mode)
;;   :custom-face
;;   (which-key-posframe ((t (:background "#282a36"))))
;;   (which-key-posframe-border ((t (:background "#6272a4")))))


;;------------------------------------------------------------------------------
;; ace-window
;;------------------------------------------------------------------------------
(use-package ace-window
  :defer t
  :init
  (spacemacs/set-leader-keys
    ;; Swap default key setting
    "ww" 'ace-window
    "wW" 'other-window))

;;------------------------------------------------------------------------------
;; eval-in-repl
;;------------------------------------------------------------------------------
(use-package eval-in-repl
  :config
  ;; (setq eir-always-split-script-window t)
  ;; (setq eir-delete-other-windows t)
  ;; (setq eir-repl-placement 'left)
  (setq eir-jump-after-eval nil))

;;; ielm support (for emacs lisp)
(use-package eval-in-repl-ielm
  :init
  (setq eir-ielm-eval-in-current-buffer t)
  (dolist (m (list emacs-lisp-mode-map
                   lisp-interaction-mode-map
                   Info-mode-map))
    (bind-keys :map m
               ("C-<return>" . eir-eval-in-ielm))))

;;; Python support
(with-eval-after-load 'python
  (use-package eval-in-repl-python
    :init
    (bind-keys :map python-mode-map ("C-<return>" . eir-eval-in-python))))
