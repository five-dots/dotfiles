;;; evil

(use-package evil-leader :disabled t
  :hook
  (evil-mode . global-evil-leader-mode)

  :config
  (evil-leader/set-leader "<SPC>"))

;; TODO Evil plugins: https://qiita.com/yukihr/items/a3841ba904979a366fb3

(use-package evil-escape
  ;; How to bind C-g to evil-escape?
  ;; https://github.com/syl20bnr/spacemacs/issues/9330

  :hook
  (evil-mode . evil-escape-mode)

  :general
  ('(insert replace visual operator)
   "C-g" #'evil-escape)

  :config
  (push #'minibufferp evil-escape-inhibit-functions) ; no `evil-escape' in minibuffer
  ;; (setq evil-escape-excluded-states '(normal visual multiedit emacs motion))
  ;; (setq evil-escape-excluded-major-modes '(neotree-mode treemacs-mode vterm-mode))
  ;; (setq evil-escape-key-sequence "jk") ; default "fd"
  (setq evil-escape-delay 0.25))

;; TODO evil-nerd-commenter

(use-package evil-surround
  ;; TODO evil-surround vs. evil-embrace
  ;; `s<textobj>'  wrap
  ;; `cs<textobj>' change
  ;; `ds<textobj>' delete

  ;; `s' for surround instead of `substitute'
  ;; see motivation here:
  ;; https://github.com/syl20bnr/spacemacs/blob/develop/doc/DOCUMENTATION.org#the-vim-surround-case
  :general
  ('visual
   evil-surround-mode-map
   "s" #'evil-surround-region
   "S" #'evil-substitute)

  :hook (evil-mode . global-evil-surround-mode))

(use-package evil-commentary
  ;; `gcc'   comment out line
  ;; `gc'    comment out selection
  ;; `gcap'  comment out paragraph
  ;; `gy'    comment out and yank
  :hook
  (evil-mode . evil-commentary-mode))

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  ;; for evil-collection
  (setq evil-want-integration t) ; default t
  (setq evil-want-keybinding nil)

  :config
  (load (expand-file-name "evil-keybind.el" my/elisp-dir))

  ;; ported from doom-emacs
  (evil-define-command my/evil-window-vsplit-and-focus (&optional count file)
    "Same as `evil-window-vsplit', but focuses (and recenters) the new split."
    :repeat nil
    (interactive "P<f>")
    (split-window (selected-window) count
                  (if evil-vsplit-window-right 'left 'right))
    (call-interactively
     (if evil-vsplit-window-right
         #'evil-window-left
       #'evil-window-right))
    (recenter)
    (when (and (not count) evil-auto-balance-windows)
      (balance-windows (window-parent)))
    (if file (evil-edit file)))

  (evil-define-command my/evil-window-split-and-focus (&optional count file)
    "Same as `evil-window-split', but focuses (and recenters) the new split."
    :repeat nil
    (interactive "P<f>")
    (split-window (selected-window) count
                  (if evil-split-window-below 'above 'below))
    (call-interactively
     (if evil-split-window-below
         #'evil-window-up
       #'evil-window-down))
    (recenter)
    (when (and (not count) evil-auto-balance-windows)
      (balance-windows (window-parent)))
    (if file (evil-edit file)))

  (evil-mode 1))

(use-package evil-collection
  ;; https://github.com/emacs-evil/evil-collection

  :config
  ;; (setq evil-collection-company-use-tng nil) ; default t
  (setq evil-collection-mode-list nil)
  (evil-collection-init
   '(
     dashboard
     help
     helpful
     info
     )))

(use-package evil-fringe-mark :disabled
  :after evil

  :config
  (setq-default evil-fringe-mark-show-special t)
  (setq-default left-fringe-width 16)
  (global-evil-fringe-mark-mode))
