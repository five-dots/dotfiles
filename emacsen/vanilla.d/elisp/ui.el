;;; ui

(when (display-graphic-p) ; disable UI elements
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (menu-bar-mode -1))

(when (display-graphic-p) ; change frame and fringe size
  ;; (setq left-fringe-width 15)
  (set-frame-size (selected-frame) 120 50))

(when (display-graphic-p) ; goto-address-mode
  (add-hook 'prog-mode-hook 'goto-address-prog-mode)
  (add-hook 'text-mode-hook 'goto-address-mode))

(use-package dashboard
  :config
  ;; display dashboard from emacsclient -c
  ;; (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (dashboard-setup-startup-hook))

(use-package all-the-icons
  :defer t
  :config
  (add-to-list
   'all-the-icons-mode-icon-alist
   '(inferior-ess-r-mode all-the-icons-fileicon "R" :face all-the-icons-lblue)))

(use-package hydra)

(use-package hide-mode-line
  :hook (treemacs-mode . hide-mode-line-mode))

(use-package doom-themes
  :preface
  (defvar region-fg nil)

  :init
  (load-theme 'doom-one t)

  :config
  ;; (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package doom-modeline
  ;; Message buffer's modeline is without theme
  ;; https://github.com/seagle0128/doom-modeline/issues/34

  :init (doom-modeline-init))

(use-package which-key
  :init
  (which-key-mode)
  (which-key-setup-minibuffer)

  :config
  (setq which-key-sort-order 'which-key-key-order-alpha)
  (setq which-key-idle-delay 0.5))

(use-package hl-todo
  :hook
  (prog-mode . hl-todo-mode))

(use-package beacon
  :hook
  (after-init . beacon-mode)

  :config
  (setq beacon-blink-when-window-scrolls nil))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode))

(use-package highlight-indent-guides
  :defer t
  :config
  (setq highlight-indent-guides-method 'character))

(use-package page-break-lines
  :config
  (add-to-list 'page-break-lines-modes 'ess-r-mode)
  (add-to-list 'page-break-lines-modes 'python-mode)
  (global-page-break-lines-mode))

(use-package tabbar :disabled
  :defer t

  :commands
  tabbar-mode

  ;; :init
  ;; (add-hook 'org-mode-hook (lambda () (tabbar-mode 1)))

  :config
  (setq tabbar-use-images nil)
  (setq tabbar-buffer-groups-function nil)
  (setq tabbar-buffer-home-button nil)
  (setq tabbar-scroll-left-button nil)
  (setq tabbar-scroll-right-button nil)
  (setq tabbar-separator '(1.5))
  ;;; Buffer list
  (setq tabbar-buffer-list-function 'my/tabbar-buffer-list)
  ;;; faces
  (when window-system
    (set-face-attribute 'tabbar-default nil
                        :foreground "#bbc2cf"
                        :background "#23272e"
                        :weight 'normal
                        :slant 'normal
                        )
    (set-face-attribute 'tabbar-selected nil
                        :weight 'bold
                        )
    (set-face-attribute 'tabbar-unselected nil
                        :foreground "#5b6268"
                        )
    (set-face-attribute 'tabbar-modified nil
                        :foreground "#FD6F68"
                        :weight 'normal
                        )
    (set-face-attribute 'tabbar-selected-modified nil
                        :foreground "#FD6F68"
                        :weight 'bold
                        )
    ;; (set-face-attribute 'tabbar-button nil
    ;;                     :box nil)
    ;; (set-face-attribute 'tabbar-separator nil
    ;;                     :height 1.0)
    ))

(use-package centaur-tabs :disabled
  :hook
  (after-init . centaur-tabs-mode)
  ;; disabled modes
  (treemacs-mode . centaur-tabs-local-mode)

  :config
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-gray-out-icons 'buffer)
  (setq centaur-tabs-set-bar 'left)
  (setq centaur-tabs-cycle-scope 'tabs)

  ;; Prevent the access to specified buffers
  (defun centaur-tabs-hide-tab (x)
    (let ((name (format "%s" x)))
      (or
       (and (string-prefix-p "*" name)
            ;; enabled buffers starting from "*"
            (not (string-prefix-p "*R" name))
            (not (string-prefix-p "*Python" name))
            (not (string-prefix-p "*shell" name)) ;
            (not (string-prefix-p "*ansi-term" name)) ;
            (not (string-prefix-p "*eshell" name)))
       ;; magit
       (string-prefix-p "COMMIT_EDITMSG" name)
       (and (string-prefix-p "magit" name)
            (not (file-name-extension name))))))

  ;; buffer group function
  (defun centaur-tabs-buffer-groups ()
    (list
     (cond
      ((memq major-mode '(inferior-ess-r-mode
                          inferior-python-mode
                          eshell-mode
                          term-mode
                          ))
       "repl")
      ((derived-mode-p 'prog-mode)
       "coding")
      ((memq major-mode '(markdown-mode
                          text-mode
                          org-mode
                          org-src-mode
                          org-agenda-mode))
       "editing")
      ;; ((string-prefix-p "*" (buffer-name))
      ;;  "emacs")
      (t "other"))))
  (centaur-tabs-headline-match))

(use-package window-purpose
  :defer t

  :config
  ;; (add-to-list 'purpose-user-mode-purposes
  ;;              '(inferior-ess-r-mode . iess))
  (purpose-compile-user-configuration))

(progn ; font
  ;; |abcdef ghijkl|
  ;; |ABCDEF GHIJKL|
  ;; |'";:-+ =/\~`?|
  ;; |∞≤≥∏∑∫ ×±⊆⊇|
  ;; |αβγδεζ ηθικλμ|
  ;; |ΑΒΓΔΕΖ ΗΘΙΚΛΜ|
  ;; |日本語 の美観|
  ;; |あいう えおか|
  ;; |アイウ エオカ|
  ;; |ｱｲｳｴｵｶ ｷｸｹｺｻｼ|
  (let ((num-disp (length (display-monitor-attributes-list)))
        (font-height 98)) ; default font height (size)
    ;; High DPI and no external display
    (when (and (equal system-name "x1") (= num-disp 1))
      (setq font-height 163)) ; or 143 for smaller font
    (set-face-attribute 'default nil :family my/fixed-latin-sans-font :height font-height))

  (set-fontset-font nil 'japanese-jisx0213.2004-1 (font-spec :family my/fixed-jp-sans-font))
  (set-fontset-font nil 'japanese-jisx0213-2 (font-spec :family my/fixed-jp-sans-font))
  (set-fontset-font nil 'katakana-jisx0201 (font-spec :family my/fixed-jp-sans-font))
  (set-fontset-font nil '(#x0250 . #x02AF) (font-spec :family my/fixed-latin-sans-font))
  (set-fontset-font nil '(#x00A0 . #x00FF) (font-spec :family my/fixed-latin-sans-font))
  (set-fontset-font nil '(#x0100 . #x017F) (font-spec :family my/fixed-latin-sans-font))
  (set-fontset-font nil '(#x0180 . #x024F) (font-spec :family my/fixed-latin-sans-font))
  (set-fontset-font nil '(#x2018 . #x2019) (font-spec :family my/fixed-latin-sans-font))
  (set-fontset-font nil '(#x2588 . #x2588) (font-spec :family my/fixed-latin-sans-font))
  (set-fontset-font nil '(#x2500 . #x2500) (font-spec :family my/fixed-latin-sans-font))
  (set-fontset-font nil '(#x2504 . #x257F) (font-spec :family my/fixed-latin-sans-font))
  (set-fontset-font nil '(#x0370 . #x03FF) (font-spec :family my/fixed-latin-sans-font))

  (add-to-list 'face-font-rescale-alist '(".*Meiryo*." . 1.09))
  (add-to-list 'face-font-rescale-alist '(".*Yu Mincho*." . 1.09)))
