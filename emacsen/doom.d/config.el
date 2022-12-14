(setq user-full-name "Shun Asai")
(setq user-mail-address "syun.asai@gmail.com")

(load! "~/Dropbox/repos/github/five-dots/dotfiles/emacsen/elisp/const.el")
(load! "const-secret.el" my/elisp-dir)
(load! "vars.el" my/elisp-dir)
(load! "funcs.el" my/elisp-dir)

(after! recentf
  (setq recentf-max-saved-items 1000)
  (use-package! recentf-ext))

(after! evil
  ;; Switch to the new window after splitting
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)

  ;; evil-window-map
  (map!
   :map evil-window-map
   "d" #'evil-quit
   "m" #'ace-swap-window
   "O" #'delete-other-windows
   "w" #'ace-window
   "W" #'ace-delete-window

   "S"   nil
   "C-_" nil
   "C-b" nil
   "C-c" nil
   "C-f" nil
   "C-h" nil
   "C-j" nil
   "C-k" nil
   "C-l" nil
   "C-n" nil
   "C-o" nil
   "C-p" nil
   "C-r" nil
   "C-s" nil
   "C-t" nil
   "C-u" nil
   "C-v" nil
   "C-w" nil
   "C-S-r" nil
   "C-S-s" nil
   "C-S-w" nil))

(use-package! skk
  :hook
  ;; Always start with latin mode
  (evil-insert-state-entry . skk-mode)
  (skk-mode . skk-latin-mode-on)

  ;; Disable skk mode when exiting insert state
  (evil-insert-state-exit . (lambda () (when skk-mode (skk-mode -1))))

  :init
  (setq default-input-method "japanese-skk")

  :config
  ;; Disable C-j keybinds in other mode maps
  (map!
   (:after evil-org
     :map evil-org-mode-map
     :i
     "C-j" nil) ; disable org-down-element
   (:after evil
     :i
     "C-j" nil)) ; disable +default/newline

  ;; Use <henkan> to toggle input mode
  (map!
   :map skk-latin-mode-map
   "<henkan>" #'skk-kakutei
   :map skk-j-mode-map
   "<henkan>" #'skk-kakutei))

(use-package! mozc
  :disabled

  :init
  (setq default-input-method "japanese-mozc")

  :hook
  (evil-insert-state-exit . my/deactivate-ime)

  :config
  (map! :i [henkan] #'toggle-input-method)

  (setq mozc-candidate-style 'echo-area)

  ;; Disable mozc-mode properly by [muhenkan]/[zenkaku-hankaku]
  ;; http://nos.hateblo.jp/entry/20120317/1331985029
  (defadvice my/mozc-handle-event (around intercept-keys (event))
    (if (member event (list 'zenkaku-hankaku 'henkan))
        (progn
          (mozc-clean-up-session)
          (toggle-input-method))
      (progn
        ;; (message "%s" event) ; debug
        ad-do-it)))
  (ad-activate 'my/mozc-handle-event))

(use-package! mozc-im
  :disabled
  :after mozc

  :config
  (setq default-input-method "japanese-mozc-im"))

(use-package! mozc-popup
  :disabled
  :after mozc
  :config
  (setq mozc-candidate-style 'popup))

(use-package! mozc-mode-line-indicator
  :disabled
  :after mozc
  :straight nil
  :load-path "~/Dropbox/repos/github/iRi-E/mozc-el-extensions")

(use-package! mozc-isearch
  :disabled t
  :after mozc
  :straight nil
  :load-path "~/Dropbox/repos/github/iRi-E/mozc-el-extensions")

(use-package! mozc-cand-posframe
  :disabled
  :after mozc
  :config
  (setq mozc-candidate-style 'posframe))

(use-package! company-quickhelp
  :hook
  (company-mode . company-quickhelp-mode)

  :init
  (setq company-quickhelp-delay nil)

  :config
  (map!
   :map company-active-map
   "H-p" #'company-quickhelp-manual-begin))

(after! company
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 2)
  (setq company-show-numbers nil)
  (setq company-tooltip-align-annotations t)
  (setq company-global-modes
        '(not erc-mode message-mode help-mode helpful-mode
              gud-mode eshell-mode shell-mode))

  ;; ignore case
  (setq completion-ignore-case t)
  (setq read-file-name-completion-ignore-case t)
  (setq read-buffer-completion-ignore-case t)

  ;; NOTE config from centaur-emacs/doom-emacs
  ;; (setq company-tooltip-limit 12) ; default 10
  ;; (setq company-echo-delay (if (display-graphic-p) nil 0))
  ;; (setq company-require-match nil) ; default 'never (or 'company-explicit-action)
  ;; (setq company-dabbrev-ignore-case nil)  ; default 'keep-prefix
  ;; (setq company-dabbrev-downcase nil)

  ;; set frontends
  (setq
   company-frontends
   '(
     company-pseudo-tooltip-frontend
     company-echo-metadata-frontend ; default enabled
     ;; company-pseudo-tooltip-unless-just-one-frontend ; default enabled
     ;; company-preview-if-just-one-frontend ; default enabled
     ))

  ;; set backends (lsp)
  (when (featurep! :tools lsp)
    (setq +lsp-company-backend
          '(company-lsp company-files :with company-yasnippet))))

(after! company
  (when (featurep! :completion company)
    (map!
     :i "H-," #'+company/complete
     :map company-active-map
     "H-SPC" #'company-complete-common
     "<tab>" #'company-complete-selection
     "H-;"   #'company-complete-selection
     "H-."   #'company-filter-candidates
     "H-/"   #'company-search-candidates
     "H-d"   #'company-next-page
     "H-u"   #'company-previous-page
     "H-i"   #'company-show-doc-buffer
     "H-w"   #'company-show-location
     (:when (featurep! :completion ivy)
       "H-c" #'counsel-company))))

(use-package! company-stan
  :hook
  (stan-mode . company-stan-setup)

  :config
  (setq company-stan-fuzzy nil))

(use-package! all-the-icons-ivy-rich
  :hook
  (ivy-mode . all-the-icons-ivy-rich-mode)

  :init
  (setq all-the-icons-ivy-rich-icon-size 0.8)

  :config
  (let ((switch-buffer-trans
         '(:columns
           ((all-the-icons-ivy-rich-buffer-icon)
            (ivy-rich-candidate (:width 30))
            (ivy-rich-switch-buffer-size (:width 7))
            (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
            (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
            (ivy-rich-switch-buffer-project (:width 15 :face success))
            (ivy-rich-switch-buffer-path (:width 26)))
           :predicate (lambda (cand) (get-buffer cand))
           :delimiter "\t"))
        (function-trans
         '(:columns
           ((all-the-icons-ivy-rich-function-icon)
            (counsel-M-x-transformer (:width 50))
            (ivy-rich-counsel-function-docstring (:width 55 :face font-lock-doc-face)))))
        (variable-trans
         '(:columns
           ((all-the-icons-ivy-rich-variable-icon)
            (counsel-M-x-transformer (:width 50))
            (ivy-rich-counsel-function-docstring (:width 55 :face font-lock-doc-face)))))
        (recentf-trans
         '(:columns
           ((all-the-icons-ivy-rich-file-icon)
            (counsel-buffer-or-recentf-transformer))
           :delimiter "\t"))
        (bookmark-trans
         '(:columns
           ((ivy-rich-bookmark-type)
            (all-the-icons-ivy-rich-bookmark-name (:width 30))
            (ivy-rich-bookmark-info (:width 74)))
           :delimiter "	")))
    ;; switch-buffer
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'ivy-switch-buffer switch-buffer-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'ivy-switch-buffer-other-window switch-buffer-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-switch-buffer switch-buffer-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-switch-buffer-other-window switch-buffer-trans)
    ;; function icons
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-M-x function-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-describe-function function-trans)
    ;; variable icons
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-describe-variable variable-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-set-variable variable-trans)
    ;; recentf
    ;; TODO trancate long path string into one line
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-recentf recentf-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-buffer-or-recentf recentf-trans)
    ;; bookmark
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-bookmark bookmark-trans))

  ;; reload ivy-rich-mode to apply configuration
  (ivy-rich-mode -1)
  (ivy-rich-mode +1))

(after! ivy
  (setq ivy-height 10)
  (setq ivy-use-virtual-buffers t))

(after! ivy-posframe
  (setq ivy-posframe-border-width 1)
  (setq ivy-posframe-width 110)
  (setq ivy-posframe-min-width 110)
  (setq ivy-posframe-min-height 10)
  (setq ivy-posframe-parameters
        '((left-fringe  . 5) (right-fringe . 5)))

  ;; Per command settings
  (setq ivy-posframe-display-functions-alist
        '((swiper . ivy-posframe-display-at-frame-bottom-window-center)
          (swiper-isearch . ivy-posframe-display-at-frame-bottom-window-center)
          (swiper-isearch-thing-at-point . ivy-posframe-display-at-frame-bottom-window-center)
          (counsel-rg . ivy-posframe-display-at-frame-bottom-window-center)
          (counsel-yank-pop . ivy-posframe-display-at-frame-bottom-window-center)
          (t . ivy-posframe-display-at-frame-center)))

  ;; Per command height settings
  (setq ivy-posframe-height-alist
        '((counsel-yank-pop . 15)
          (t . 10)))

  (set-face-attribute 'ivy-posframe nil :background "#282a36")
  (set-face-attribute 'ivy-posframe-border nil :background "#6272a4")
  (set-face-attribute 'ivy-posframe-cursor nil :background "#61bfff"))

(after! counsel
  ;; align with ivy-posframe-width
  (setq counsel-yank-pop-separator
        "\n--------------------------------------------------------------------------------------------------------------\n"))

(let ((num-disp (length (display-monitor-attributes-list)))
      (font-size 13)
      (big-font-size 19))
  ;; Larger font for high DPI Display
  (cond
   ;; mbp
   ((and (string= (system-name) "mbp1.local") (= num-disp 1))
    (setq font-size 15)
    (setq big-font-size 21))
   ;; x1
   ((and (string= (system-name) "x1") (= num-disp 1))
    (setq font-size 19)
    (setq big-font-size 27)))

  (setq doom-font (font-spec :family my/fixed-latin-sans-font :size font-size))
  (setq doom-big-font (font-spec :family my/fixed-latin-sans-font :size big-font-size))
  (setq doom-unicode-font (font-spec :family my/fixed-jp-sans-font :size font-size))
  (setq doom-serif-font doom-unicode-font)

  (my/set-latin-greek-fonts t my/fixed-latin-sans-font)
  (add-to-list 'face-font-rescale-alist '(".*Meiryo*." . 1.09)))

(setq display-line-numbers-type nil)

(setq doom-theme 'doom-one)

(when (display-graphic-p)
  (set-frame-size (selected-frame) 120 50))

(after! doom-themes
  ;; neotree
  (setq doom-themes-neotree-enable-variable-pitch nil)

  ;; treemacs
  (setq doom-themes-treemacs-theme "Default") ; "doom-atom" or "Default"
  (setq doom-themes-treemacs-enable-variable-pitch nil))

(after! neotree
  (setq neo-window-position 'right))

(after! treemacs
  (treemacs-resize-icons 16) ; default 22
  (treemacs-git-mode 'deferred)
  (setq treemacs-position 'right)
  (setq treemacs-lock-width t)
  (setq treemacs-show-cursor t))

(use-package! page-break-lines
  :config
  (add-to-list 'page-break-lines-modes 'ess-r-mode)
  (add-to-list 'page-break-lines-modes 'python-mode)

  (global-page-break-lines-mode))

(after! all-the-icons
  ;; https://github.com/domtronn/all-the-icons.el

  ;; (insert (all-the-icons-icon-for-buffer)???)
  ;; (insert (all-the-icons-icon-for-dir "~/")???)
  ;; (insert (all-the-icons-icon-for-file "foo.R")???)
  ;; (insert (all-the-icons-icon-for-mode 'emacs-lisp-mode)???)
  ;; (insert (all-the-icons-icon-for-url "https://google.com")???)

  ;; see below list for more details
  ;; all-the-icons-data/octicons-alist
  ;; all-the-icons-data/alltheicons-alist
  ;; all-the-icons-data/fa-icon-alist
  ;; all-the-icons-data/material-icons-alist
  ;; all-the-icons-data/material-icons-alist

  ;; file icons
  (add-to-list
   'all-the-icons-icon-alist
   '("\\.desktop$" all-the-icons-faicon "desktop"
     :height 1.0 :v-adjust 0.0 :face all-the-icons-blue))

  ;; mode icons
  (add-to-list
   'all-the-icons-mode-icon-alist
   '(inferior-ess-r-mode all-the-icons-fileicon "R" :face all-the-icons-lblue)))

(use-package! centaur-tabs
  :disabled

  :config
  ;; disabled modes
  (add-hook 'treemacs-mode-hook #'centaur-tabs-local-mode)

  (setq centaur-tabs-cycle-scope 'tabs) ; tabs, groups, default
  (setq centaur-tabs-close-button "x")
  (setq centaur-tabs-modified-marker "*")

  ;; Prevent the access to specified buffers
  (defun centaur-tabs-hide-tab (x)
    (let ((name (format "%s" x)))
      (or
       ;; buffers start from "*"
       (and (string-prefix-p "*" name)
            ;; (not) exclude list
            (not (string-prefix-p "*R" name))
            (not (string-prefix-p "*Python" name))
            (not (string-prefix-p "*ielm" name))
            (not (string-prefix-p "*shell" name))
            (not (string-prefix-p "*ansi-term" name))
            (not (string-prefix-p "*eshell" name))
            (not (string-prefix-p "*ess-describe" name))
            )
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
                          inferiro-emacs-lisp-mode ; ielm
                          shell-mode
                          term-mode ; ansi-term
                          eshell-mode
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
      (t "other"))))

  (map!
   :m "H-C-," #'centaur-tabs-backward
   :m "H-C-." #'centaur-tabs-forward))

(use-package! hydra-posframe
  :hook
  (after-init . hydra-posframe-mode)

  :config
  ;; TODO (seqt hydra-posframe-show-params)

  (setq hydra-posframe-border-width 1)
  (setq hydra-posframe-parameters
        '((left-fringe . 10)
          (right-fringe . 10)))

  ;; (set-face-attribute 'hydra-posframe-face nil :background "#282a36")
  (set-face-attribute 'hydra-posframe-border-face nil :background "#6272a4"))

(use-package! major-mode-hydra
  :bind
  ("H-SPC" . major-mode-hydra))

(when (featurep! :ui fill-column)
  (remove-hook! '(text-mode-hook prog-mode-hook conf-mode-hook) #'hl-fill-column-mode))

(when (featurep! :ui popup)
  (set-popup-rules!
    '(
      ;; Help/Helpful
      ;; ("^\\*[Hh]elp"
      ;;  ;; :actions (display-buffer-reuse-window display-buffer-below-selected)
      ;;  :actions (display-buffer-below-selected)
      ;;  ;; :slot 2
      ;;  ;; :vslot -8
      ;;  :height 0.35
      ;;  :select t
      ;;  :quit t)

      ("^\\*General Keybindings\\*$" :ignore t)
      ("^\\*lsp session\\*$" :ignore t)

      ;; TODO company-diag
      ;; TODO google-translate
      ;; TODO company-doc
      )))

(after! yasnippet
  (add-to-list 'yas-snippet-dirs my/snippets-dir))

(when (featurep! :checkers syntax)
  (global-flycheck-mode -1)
  (add-hook!
   '(
     ;; emacs-lisp-mode-hook
     ess-r-mode-hook
     )
   #'flycheck-mode))

(when (featurep! :ui popup)
    (set-popup-rules!
      '(
        ;; flycheck-list-errors
        ("^\\*Flycheck errors"
         :actions (display-buffer-reuse-window display-buffer-below-selected)
         :height 0.3
         :select t
         )
        )))

(after! lsp-mode
  (setq lsp-disabled-clients '(pyls)) ; use mspyls
  (setq lsp-enable-snippet t) ; default t
  (setq lsp-auto-guess-root nil)

  ;; popup rules
  (when (featurep! :ui popup)
    (set-popup-rules!
      '(("^\\*lsp-help"
         :actions (display-buffer-reuse-window display-buffer-below-selected)
         :height 0.5
         :select t
         )
        ))))

(after! lsp-ui
  ;; lsp-ui-doc
  (setq lsp-ui-doc-enable nil)
  ;; (setq lsp-ui-doc-delay 1) ; 0.2
  ;; (setq lsp-ui-doc-header nil)
  ;; (setq lsp-ui-doc-include-signature t)
  ;; (setq lsp-ui-doc-position 'at-point)
  ;; (setq lsp-ui-doc-alignment 'frame) ; frame or window
  ;; (setq lsp-ui-doc-max-width 150)
  ;; (setq lsp-ui-doc-max-height 30)
  ;; (setq lsp-ui-doc-use-childframe t)
  ;; (setq lsp-ui-doc-use-webkit nil)

  ;; lsp-ui-flycheck
  (setq lsp-ui-flycheck-enable t)

  ;; lsp-ui-peek
  (setq lsp-ui-peek-enable t)
  ;; (setq lsp-ui-peek-peek-height 20)
  ;; (setq lsp-ui-peek-list-width 50)
  ;; (setq lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always

  ;; lsp-ui-imenu
  (setq lsp-ui-imenu-enable nil)
  ;; (setq lsp-ui-imenu-kind-position 'top)

  ;; lsp-ui-sideline
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-code-actions-prefix "???")
  ;; (setq lsp-ui-sideline-ignore-duplicate t) ; nil
  ;; (setq lsp-ui-sideline-show-symbol t)
  ;; (setq lsp-ui-sideline-show-hover nil) ; nil
  ;; (setq lsp-ui-sideline-show-diagnostics t) ; t
  ;; (setq lsp-ui-sideline-show-code-actions t) ;t
  )

(after! dap-mode
  ;; TODO dap-ui-mode debug ??????????????????????????????????????????
  ;; TODO hydra map ???????????????????????????
  ;; TODO dap-python
  ;; TODO dap-gdb-lldb
  )

(use-package! nameless
  :defer t)

(use-package google-translate
  :defer t

  :init
  (setq google-translate-pop-up-buffer-set-focus t)
  (setq google-translate-default-source-language "en")
  (setq google-translate-default-target-language "ja")

  (map!
   :leader
   (:prefix-map ("x" . "text")
     (:prefix-map ("g". "google-translate")
       "t" #'google-translate-at-point
       "T" #'google-translate-at-point-reverse
       "q" #'google-translate-query-translate
       "Q" #'google-translate-query-translate-reverse))))

(use-package! eldoc-stan
  :disabled

  :hook
  (stan-mode . eldoc-stan-setup))

(after! elisp-mode
  ;; company-backends
  (set-company-backend! '(emacs-lisp-mode lisp-interaction-mode)
    '(company-capf company-files :with company-yasnippet))

  ;; (major-mode-hydra-define emacs-lisp-mode
  ;;   (:title "Emacs Lisp Mode" :quit-key "q")
  ;;   ("Eval"
  ;;    (("b" eval-buffer "buffer")
  ;;     ("e" eval-defun "defun")
  ;;     ("r" eval-region "region")
  ;;    "REPL"
  ;;    (("I" ielm "ielm"))
  ;;    "Test"
  ;;    (("t" ert "prompt")
  ;;     ("T" (ert t) "all")
  ;;     ("F" (ert :failed) "failed"))
  ;;    "Doc"
  ;;    (("d" describe-foo-at-point "thing-at-pt")
  ;;     ("f" describe-function "function")
  ;;     ("v" describe-variable "variable")
  ;;     ("i" info-lookup-symbol "info lookup")))))
  )

(map!
 :localleader
 :map emacs-lisp-mode-map
 "h" #'helpful-at-point
 (:prefix ("e" . "eval")
   "d" nil
   "f" #'eval-defun
   "x" #'lispxmp))

(setq org-directory "~/Dropbox/repos/github/five-dots/notes/org/")

(after! org
  ;;TODO enable visual-line-mode for org-mode

  ;; company-backends
  (when (featurep! :completion company)
    (set-company-backend! 'org-mode
      '(company-dabbrev company-files :with company-yasnippet)))

  ;; Replace "-" with "???"
  (font-lock-add-keywords
   'org-mode
   '(("^ *\\([-]\\) "
      (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "???"))))))
  (setq org-hide-emphasis-markers t)

  ;; faces
  (set-face-attribute 'org-level-1 nil :slant 'italic :height 1.0)
  ;; (set-face-attribute 'org-block-end-line nil :foreground "#23272e")

  ;; org-agenda
  ;; Add agenda file recursively
  ;; https://www.reddit.com/r/orgmode/comments/6q6cdk/adding_files_to_the_agenda_list_recursively/
  (setq org-agenda-files
        (apply 'append
               (mapcar (lambda (directory)
                         (directory-files-recursively directory org-agenda-file-regexp))
                       '("~/Dropbox/repos/github/five-dots/notes/org"))))

  ;; agenda format
  ;; Aligned Agenda View. Anyway to make this more clean? IE, having the TODO Keywords all line up?
  ;; https://www.reddit.com/r/orgmode/comments/6ybjjw/aligned_agenda_view_anyway_to_make_this_more/
  ;; (setq org-agenda-prefix-format
  ;;       (quote
  ;;        ((agenda . " %i %-12:c%?12t% s")
  ;;         (todo   . " %i %-12:c")
  ;;         (tags   . " %i %-12:c")
  ;;         (search . " %i %-12:c"))))

  ;; org-babel
  ;; org-mode fontification error with org src blocks #8455
  ;; https://github.com/syl20bnr/spacemacs/issues/8455
  ;; (setq org-src-fontify-natively t)
  ;; (setq org-src-tab-acts-natively t)
  ;; (setq org-image-actual-width nil)
  ;; (org-babel-jupyter-override-src-block "python")
  (setq org-src-window-setup 'split-window-below)

  ;; Latex preview
  ;; (setq org-preview-latex-default-process 'dvisvgm)
  ;; (plist-put org-format-latex-options :scale 1.5)
  (setq org-preview-latex-image-directory "~/Dropbox/memo/img/latex/")

  ;; org-capture
  (setq
   org-capture-templates
   '(("t" "Personal todo" entry
      (file+headline +org-capture-todo-file "Inbox")
      "* [ ] %?\n%i\n%a" :prepend t)
     ("r" "Personal reading list" entry
      (file+headline +org-capture-todo-file "Reading List")
      "* [ ] %?\n%i\n%a" :prepend t)
     ("n" "Personal notes" entry
      (file+headline +org-capture-notes-file "Inbox")
      "* %u %?\n%i\n%a" :prepend t)
     ("j" "Journal" entry
      (file+olp+datetree +org-capture-journal-file)
      "* %U %?\n%i\n%a" :prepend t)

     ;; Project templates
     ("p" "Templates for projects")
     ("pt" "Project-local todo" entry
      (file+headline +org-capture-project-todo-file "Inbox")
      "* TODO %?\n%i\n%a" :prepend t)
     ("pn" "Project-local notes" entry
      (file+headline +org-capture-project-notes-file "Inbox")
      "* %U %?\n%i\n%a" :prepend t)
     ("pc" "Project-local changelog" entry
      (file+headline +org-capture-project-changelog-file "Unreleased")
      "* %U %?\n%i\n%a" :prepend t)

     ;; Centralized templates
     ("o" "Centralized templates for projects")
     ("ot" "Project todo" entry
      #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
     ("on" "Project notes" entry
      #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
     ("oc" "Project changelog" entry
      #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t))))

(map!
 :localleader
 (:after org
   :map org-mode-map
   "," #'org-ctrl-c-ctrl-c))

(after! org-superstar
  (setq org-superstar-headline-bullets-list
        '("???" "???" "???" "???" "???" "???" "???" "???" "???" "???")))

(after! org-download
  (setq org-download-image-dir (expand-file-name "~/Dropbox/memo/img/download")))

(after! ox
  (add-to-list 'org-export-filter-latex-fragment-functions 'my/org-replace-latex-wrap))

(after! ox-hugo
  (setq org-hugo-section "post")
  (setq org-hugo-front-matter-format "toml") ; toml or yaml
  (setq org-hugo-use-code-for-kbd t))

(use-package! ox-qmd
  :config
  (add-to-list 'ox-qmd-language-keyword-alist '("R" . "r")))

(use-package! ox-gfm)

(use-package! org-variable-pitch
  :disabled

  :commands
  (org-variable-pitch-minor-mode)

  ;; :init
  ;; (add-hook 'org-mode-hook (lambda () (org-variable-pitch-minor-mode 1)))

  :config
  (dolist (f org-variable-pitch-fixed-faces)
    (set-face-attribute f nil :fontset "fontset-auto1" :font "fontset-auto1")))

(use-package! org-babel-eval-in-repl
  :disabled

  :init
  (map!
   :map org-mode-map
   :m "C-<return>" #'ober-eval-in-repl))

(use-package! org-qiita
  :disabled

  ;; Private Layer ?????? github ????????????????????????????????????????????????????????????
  ;; Error getting PACKAGE-DESC: (error Package lacks a file header)
  :load-path "~/Dropbox/repos/github/ifritJP/org-qiita-el"

  :config
  (setq org-qiita-token my/qiita-token)
  (setq org-qiita-export-and-post nil))

(after! ess
  ;; company-backend
  (set-company-backend! '(ess-r-mode inferior-ess-r-mode)
    '(company-R-library company-R-args company-R-objects company-files
                        :with company-yasnippet))

  (setq ess-offset-continued '(straight . 2)) ; or '(cascade . 2)
  (setq ess-eldoc-show-on-symbol t)
  (setq ess-history-file nil)
  (setq ess-style 'RStudio)
  (setq ess-indent-with-fancy-comments nil)
  (setq ess-eval-visibly t)

  ;; Disable unnecessary completion
  (setq ess-use-R-completion nil)
  (setq ess-use-ido nil)

  ;; object popup by tooltip
  (setq ess-describe-at-point-method nil) ; or 'tooltip
  (setq x-gtk-use-system-tooltips nil)
  ;; TODO colored str by {crayon}
  (setq ess-R-describe-object-at-point-commands
        '(("str(%s)")
          (".ess_htsummary(%s, hlength = 20, tlength = 20)")
          ("summary(%s, maxsum = 20)")))

  (set-evil-initial-state! 'inferior-ess-r-mode 'normal))

(when (featurep! :checkers syntax)
  (setq flycheck-lintr-linters
        "with_defaults(
           line_length_linter(length = 80L),
           implicit_integer_linter,
           T_and_F_symbol_linter,
           todo_comment_linter,
           object_name_linter = NULL,
           cyclocomp_linter = NULL,
           pipe_continuation_linter = NULL,
           commented_code_linter = NULL
        )"))

(after! ess
  (when (featurep! :ui popup)
    (set-popup-rules!
      '(
        ("^\\*R" :ignore t)

        ("^\\*R dired"
         :actions (display-buffer-reuse-window display-buffer-below-selected)
         :height 0.2
         :quit nil)

        ;; Variable viewer by R dired
        ("^\\*R view\\*$"
         :select t
         :size +popup-shrink-to-fit)

        ;; ess-describe-object-at-point
        ("^\\*ess-describe"
         :actions (display-buffer-reuse-window display-buffer-below-selected)
         :height 0.6)

        ;; ess-R-dv-ctable
        ("^\\*Table: "
         :actions (display-buffer-reuse-window display-buffer-below-selected)
         :height 0.6)

        ;; ("^\\*help\\[R\\](" :side right :size 81 :select t :quit current)
        ))))

(after! ess
  (map!
   (:after ess-help
     (:map ess-doc-map
       "RET" nil
       "TAB" nil
       "C-<return>" nil
       "<down>" nil
       "<up>" nil
       "C-a" nil
       "C-d" nil
       "C-e" nil
       "C-o" nil
       "C-v" nil
       "C-w" nil
       "d" nil
       "m" nil
       "p" nil
       "t" nil
       ))

   (:after ess-rdired
     (:map ess-rdired-mode-map
       :n "d" #'ess-rdired-delete
       :n "p" #'ess-rdired-plot
       :n "q" #'ess-rdired-quit
       :n "r" #'revert-buffer
       :n "v" #'my/ess-print-at-point
       :n "x" #'ess-rdired-delete
       :n "y" #'ess-rdired-type
       ))

   (:map ess-dev-map
     "C-b" nil
     "C-d" nil
     "C-e" nil
     "C-k" nil
     "C-l" nil
     "C-n" nil
     "C-o" nil
     "C-p" nil
     "C-s" nil
     "C-u" nil
     "C-w" nil)

   (:map ess-extra-map
     "b"   #'ess-eval-buffer
     "f"   #'ess-eval-function
     "s"   #'ess-switch-process
     "S"   #'ess-set-style
     "p"   #'my/ess-load-projecttemplate-project
     "TAB" nil
     "C-d" nil
     "C-e" nil
     "C-l" nil
     "C-r" nil
     "C-s" nil
     "C-t" nil
     "C-w" nil)

   (:map ess-r-package-dev-map
     "C-a" nil
     "C-b" nil
     "C-c" nil
     "c C-c" nil
     "c C-w" nil
     "C-d" nil
     "C-e" nil
     "C-l" nil
     "C-s" nil
     "C-t" nil
     "C-u" nil
     "f" #'my/ess-r-devtools-test-file)

   (:map inferior-ess-r-mode-map
     :i "," #'ess-smart-comma)

   (:map ctbl:table-mode-map
     :n "q" #'kill-this-buffer)

   (:map ess-r-mode-map
     :m "C-<return>" #'ess-eval-region-or-line-visibly-and-step)

   :localleader
   (:map ess-r-mode-map
     ","   #'ess-eval-region-or-function-or-paragraph
     "."   #'ess-describe-object-at-point
     ";"   #'my/ess-print-at-point
     "["   #'my/ess-str-at-point
     "0"   #'ess-rdired
     "TAB" #'ess-switch-to-inferior-or-script-buffer

     ;; predefined map
     "d" #'ess-dev-map
     "e" #'ess-extra-map
     "h" #'ess-doc-map
     "p" #'ess-r-package-dev-map
     "v" nil ; v=view
     "x" nil

     (:prefix ("c" . "chunk"))
     (:prefix ("d" . "debug"))
     (:prefix ("e" . "eval"))
     (:prefix ("h" . "help"))
     (:prefix ("p" . "package-dev"))
     (:prefix ("pc" . "check"))
     (:prefix ("s" . "show")
       "p" #'my/ess-print-at-point
       "r" #'my/ess-str-at-point
       "t" #'ess-R-dv-ctable
       "s" #'ess-r-spreadsheet)

     ;; disable some binds
     [tab] nil
     [backtab] nil
     "b" nil
     "B" nil
     "D" nil
     "f" nil
     "F" nil
     "l" nil
     "L" nil
     "r" nil
     "R" nil)

   :localleader
   (:map inferior-ess-r-mode-map
     "."   #'ess-describe-object-at-point
     "TAB" #'ess-switch-to-inferior-or-script-buffer)))

(after! ess
  ;; custom functions for ess-tracebug
  (defun my/ess-debug-command-step-into ()
    "Step into the next code. Equivalent of `s' at the R prompt."
    (interactive)
    (ess-force-buffer-current)
    (cond ((ess--dbg-is-recover-p)
           (ess-send-string (ess-get-process) "0"))
          ((ess--dbg-is-active-p)
           (ess-send-string (ess-get-process) "s"))
          (t
           (error "Debugger is not active"))))

  (defhydra my/hydra-ess-tracebug (:color pink :hint nil)
    "
^Stepping^            ^Breakpoints^        ^Debugging^
^^--------------------^^-------------------^^------------------------
_sc_: Continue        _bt_: Toggle         _d`_: Traceback
_sC_: Continue multi  _ba_: Add            _d~_: Callstack
_sn_: Next            _bd_: Delete         _de_: Toggle error action
_sN_: Next multi      _bD_: Delete all     _dd_: Flag for debugging
_su_: Up frame        _bc_: Set condition  _du_: Unflag for debugging
_sq_: Quit            _bl_: Set logger     _dw_: Watch window
"
    ;; Stepping
    ("sc" ess-debug-command-continue)
    ("sC" ess-debug-command-continue-multi)
    ("sn" ess-debug-command-next)
    ("sN" ess-debug-command-next-multi)
    ("su" ess-debug-command-up)
    ("sq" ess-debug-command-quit)
    ;; Breakpoints
    ("bt" ess-bp-toggle-state)
    ("ba" ess-bp-set)
    ("bd" ess-bp-kill)
    ("bD" ess-bp-kill-all)
    ("bc" ess-bp-set-conditional)
    ("bl" ess-bp-set-logger)
    ;; Debugging
    ("d`" ess-show-traceback)
    ("d~" ess-show-call-stack)
    ("de" ess-debug-toggle-error-action)
    ("dd" ess-debug-flag-for-debugging)
    ("du" ess-debug-unflag-for-debugging)
    ("dw" ess-watch)
    ("q" nil "Close" :color blue))

  ;; keymap
  (map!
   (:map ess-dev-map
     "." #'my/hydra-ess-tracebug/body)

   (:map ess-debug-minor-mode-map
     "M-S" #'my/ess-debug-command-step-into)))

(use-package! ess-smart-equals
  ;; https://github.com/genovese/ess-smart-equals

  :hook
  ((ess-r-mode . ess-smart-equals-mode)
   (inferior-ess-r-mode . ess-smart-equals-mode)
   (ess-r-transcript-mode . ess-smart-equals-mode)
   (ess-roxy-mode . ess-smart-equals-mode))

  :config
  ;; change % operators priority
  (setf
   (cdr (assq '% (assq 't ess-smart-equals-contexts)))
   '("%>%" "%in%" "%*%" "%%" "%/%" "%<>%" "%o%" "%x%" "%|%" "%||%"))

  (setq ess-smart-equals-extra-ops '(percent)))

(use-package! ess-r-spreadsheet
  :after
  (:any ess-r-mode inferior-ess-r-mode ess-r-transcript)

  :commands
  (ess-r-spreadsheet))

(after! python
  ;; keep executables "python" as it is switched by pyenv
  (setq python-shell-interpreter "python") ; python, python3 or ipython3
  (setq org-babel-python-command "python")

  ;; (setq python-shell-completion-native-enable nil) ; default t
  ;; (add-to-list 'python-shell-completion-native-disabled-interpreters "python") ; pypy, ipython

  ;; https://github.com/jorgenschaefer/elpy/issues/733
  ;; (setq python-shell-prompt-detect-enabled nil)
  ;; (setq python-shell-prompt-detect-failure-warning nil)

  ;; disable message "Can???t guess python-indent-offset, using defaults: 4..."
  ;; (setq python-indent-guess-indent-offset-verbose nil)

  ;; popup rules
  (when (featurep! :ui popup)
    (set-popup-rules!
      '(("^\\*Python" :ignore t))))

  ;; keymap
  (map!
   :map python-mode-map
   :nv "C-<return>" #'+eval/line-or-region
   :localleader
   :n "'" #'+eval/open-repl-other-window))

(after! pyenv-mode
  (setq pyenv-mode-mode-line-format nil)) ; disable modeline

(after! pipenv
  (map!
   :map python-mode-map
   :localleader
   :prefix ("e" . "pipenv")))

(after! omnisharp
  ;; popup
  (when (featurep! :ui popup)
    (set-popup-rules!
      '(
        ("^\\* OmniSharp : Usages"
         :actions (display-buffer-reuse-window display-buffer-below-selected)
         :height 0.3
         :select t)
        )))

  (map!
   :localleader
   :map csharp-mode-map
   (:prefix ("g" . "goto"))
   (:prefix ("r" . "refactor"))
   (:prefix ("t" . "test"))))

(use-package! dotnet
  :hook
  (csharp-mode . dotnet-mode)

  :config
  ;; popup
  (when (featurep! :ui popup)
    (set-popup-rules!
      '(
        ("^\\*dotnet"
         :actions (display-buffer-reuse-window display-buffer-below-selected)
         :height 0.3
         :select t)
        )))

  ;; dotnet
  (map!
   (:after dotnet
     :localleader
     (:map csharp-mode-map
       (:prefix ("c" . "dotnet-cli")
         :n "." #'dotnet-run
         :n "b" #'dotnet-build
         :n "c" #'dotnet-clean
         :n "n" #'dotnet-new
         :n "p" #'dotnet-add-package
         :n "r" #'dotnet-add-reference
         :n "t" #'dotnet-test)
       ;; goto
       (:prefix ("cg" . "goto")
         :n "p" #'dotnet-goto-csproj
         :n "s" #'dotnet-goto-sln)
       ;; sln
       (:prefix ("cs" . "sln")
         :n "l" #'dotnet-sln-list
         :n "n" #'dotnet-sln-new
         :n "r" #'dotnet-sln-remove)))))

(after! haskell-mode
  (setq haskell-process-type 'stack-ghci) ; 'auto, 'ghci, 'cabal-repl, 'stack-ghci, 'cabal-new-repl

  ;; popup rules
  (when (featurep! :ui popup)
    (set-popup-rules!
      '(
        ("^\\*haskell" :ignore t)
        ("^\\*HS-Error"
         :actions (display-buffer-reuse-window display-buffer-below-selected)
         :height 0.3)
        )))

  ;; keymap
  ;; (map!
  ;;  :map haskell-mode-map
  ;;  :nv "C-<return>" #'+eval/line-or-region
  ;;  :localleader
  ;;  :n "'" #'+eval/open-repl-other-window)
  )

(use-package! sqlup-mode
  ;; :config
  ;; (add-to-list 'sqlup-blacklist "name")

  :hook
  (sql-mode . sqlup-mode)
  (sql-interactive-mode . sqlup-mode))

(use-package! sql-indent
  :hook
  (sql-mode . sqlind-minor-mode))

(use-package! crontab-mode
  :mode
  (("\\.cron\\(tab\\)?\\'" . crontab-mode)
   ("cron\\(tab\\)?\\." . crontab-mode)))

(after! sh-script
  ;; company-backends
  (set-company-backend! 'sh-mode
    '(company-shell company-shell-env company-files :with company-yasnippet)))

(use-package! stan-mode
  :mode
  ("\\.stan\\'" . stan-mode)

  :hook
  (stan-mode . stan-mode-setup)

  :config
  (setq stan-indentation-offset 2)

  ;; company-backends
  (set-company-backend! 'stan-mode
    '(company-stan-backend company-files company-yasnippet))

  ;; Add snippets dir
  (add-to-list
   'yas-snippet-dirs
   (expand-file-name "straight/repos/stan-mode/stan-snippets/snippets" doom-local-dir)))

(after! calendar
  (setq calendar-week-start-day 1) ; start from Mon
  (setq calendar-mark-holidays-flag t)) ; show holiday in calendar

(use-package! japanese-holidays
  :after
  calendar

  :config
  (setq calendar-holidays japanese-holidays))

(after! calfw
  ;; popup rules
  (when (featurep! :ui popup)
    (set-popup-rules!
      '(("^\\*cfw:details\\*"
         :actions (display-buffer-reuse-window display-buffer-below-selected)
         :height 0.3)
        )))

  (map!
   :map cfw:calendar-mode-map
   ;; FIXME Use bury-buffer until +calendar/quit is fixed
   "q" #'bury-buffer
   "C-g" #'bury-buffer
   "RET" #'cfw:show-details-command

   :map cfw:details-mode-map
   :n "q" #'kill-this-buffer))

(use-package! calfw-ical)

(after! org-gcal
  (setq org-gcal-client-id my/org-gcal-client-id)
  (setq org-gcal-client-secret my/org-gcal-client-secret)

  (setq org-gcal-down-days 60) ; default 60
  (setq org-gcal-up-days 30) ; default 30

  (setq org-gcal-file-alist
        '(("syun.asai@gmail.com" .
           "~/Dropbox/repos/github/five-dots/notes/org/gcal-shared.org")
          ("sfrb7rv0u9r7pope5kvoubau6o@group.calendar.google.com" .
           "~/Dropbox/repos/github/five-dots/notes/org/gcal-work.org"))))

(when my/mac-p
  (setq mac-option-modifier 'meta) ; default meta
  (setq mac-command-modifier 'hyper))

(map!
 ;; :m "H"  #'evil-first-non-blank-of-visual-line
 ;; :m "J"  #'evil-forward-paragraph
 ;; :m "K"  #'evil-backward-paragraph
 ;; :m "L"  #'evil-end-of-visual-line

 ;; j/k
 :m "j"  #'evil-next-visual-line
 :m "gj" #'evil-next-line
 :m "k"  #'evil-previous-visual-line
 :m "gk" #'evil-previous-line

 ;; home/end
 :m "0"  #'evil-first-non-blank-of-visual-line
 :m "g0" #'evil-first-non-blank
 :m "^"  #'evil-beginning-of-visual-line
 :m "g^" #'evil-digit-argument-or-evil-beginning-of-line
 :m "$"  #'evil-end-of-visual-line
 :m "g$" #'evil-end-of-line

 ;; window navigation
 :m "H-C-h" #'evil-window-left
 :m "H-C-j" #'evil-window-down
 :m "H-C-k" #'evil-window-up
 :m "H-C-l" #'evil-window-right

 ;; Hyper shortcuts
 :m "H-;" #'evil-avy-goto-char-2
 :m "H-," #'counsel-switch-buffer
 :m "H-/" #'swiper-isearch

 :m "H-b" #'evil-backward-char
 :i "H-b" #'backward-delete-char-untabify
 :i "H-B" #'backward-kill-word
 :i "H-n" #'evil-delete-char)

(map!
 :leader
 :desc "M-x"                   "SPC" #'counsel-M-x
 :desc "Switch buffer"         ","   #'counsel-switch-buffer
 :desc "Switch to last buffer" "TAB" #'evil-switch-to-windows-last-buffer

 (:when (featurep! :ui treemacs)
   :desc "Project sidebar" "0" #'treemacs-select-window)

 (:when (featurep! :ui tabs)
   :desc "Switch tab group" "RET" #'centaur-tabs-counsel-switch-group)

 :desc "Resume last search" "."
 (cond ((featurep! :completion ivy) #'ivy-resume)
       ((featurep! :completion helm) #'helm-resume))

 ":" nil ; M-x
 "'" nil ; Resume last search
 "`" nil ; Switch to last buffer

 ;; workspace
 ;; (:when (featurep! :ui workspaces)
 ;;   :desc "Switch workspace buffer" "<" #'persp-switch-to-buffer
 ;;   :desc "Switch buffer" "," #'switch-to-buffer
 ;;   (:prefix-map ("W" . "workspace")
 ;;     :desc "Display tab bar"           "TAB" #'+workspace/display
 ;;     :desc "Switch workspace"          "."   #'+workspace/switch-to
 ;;     :desc "Switch to last workspace"  "`"   #'+workspace/other
 ;;     :desc "New workspace"             "n"   #'+workspace/new
 ;;     :desc "Load workspace from file"  "l"   #'+workspace/load
 ;;     :desc "Save workspace to file"    "s"   #'+workspace/save
 ;;     :desc "Delete session"            "x"   #'+workspace/kill-session
 ;;     :desc "Delete this workspace"     "d"   #'+workspace/delete
 ;;     :desc "Rename workspace"          "r"   #'+workspace/rename
 ;;     :desc "Restore last session"      "R"   #'+workspace/restore-last-session
 ;;     :desc "Next workspace"            "]"   #'+workspace/switch-right
 ;;     :desc "Previous workspace"        "["   #'+workspace/switch-left
 ;;     :desc "Switch to 1st workspace"   "1"   #'+workspace/switch-to-0
 ;;     :desc "Switch to 2nd workspace"   "2"   #'+workspace/switch-to-1
 ;;     :desc "Switch to 3rd workspace"   "3"   #'+workspace/switch-to-2
 ;;     :desc "Switch to 4th workspace"   "4"   #'+workspace/switch-to-3
 ;;     :desc "Switch to 5th workspace"   "5"   #'+workspace/switch-to-4
 ;;     :desc "Switch to 6th workspace"   "6"   #'+workspace/switch-to-5
 ;;     :desc "Switch to 7th workspace"   "7"   #'+workspace/switch-to-6
 ;;     :desc "Switch to 8th workspace"   "8"   #'+workspace/switch-to-7
 ;;     :desc "Switch to 9th workspace"   "9"   #'+workspace/switch-to-8
 ;;     :desc "Switch to final workspace" "0"   #'+workspace/switch-to-final))

 ;; google search
 ;; (:prefix-map ("/ g " . "google")
 ;;   "g" #'google-this
 ;;   "t" #'google-translate-at-point
 ;;   "T" #'google-translate-at-point-reverse
 ;;   "q" #'google-translate-query-translate
 ;;   "Q" #'google-translate-query-translate-reverse)

 (:prefix-map ("o" . "open")
   (:when (featurep! :ui treemacs)
     :desc "Project sidebar" "p" #'treemacs-select-window
     :desc "Find file in project sidebar" "P" #'treemacs-find-file)

   ;; Calendar
   (:when (featurep! :app calendar)
     :desc "Calendar" "c" #'my/open-calendar
     ;; (:prefix-map ("c" . "calendar")
     ;;   :desc "Calendar"      "c" #'my/open-calendar
     ;;   :desc "Fetch"         "f" #'org-gcal-fetch
     ;;   :desc "Fetch buffer"  "b" #'org-gcal-fetch-buffer
     ;;   :desc "Sync"          "s" #'org-gcal-sync
     ;;   :desc "Sync buffer"   "S" #'org-gcal-sync-buffer
     ;;   :desc "Post"          "p" #'org-gcal-post-at-point
     ;;   :desc "Delete"        "d" #'org-gcal-delete-at-point
     ;;   :desc "Request auth"  "a" #'org-gcal-request-authorization
     ;;   :desc "Request token" "t" #'org-gcal-request-token
     ;;   )
     ))

 (:prefix-map ("t" . "toggle")
   (:when (featurep! :ui fill-column)
     :desc "Fill column" "C" #'hl-fill-column-mode)))

(map!
 :map help-map)

(map!
 (:map comint-mode-map
   :m "H-C-h" #'evil-window-left
   :m "H-C-j" #'evil-window-down
   :m "H-C-k" #'evil-window-up
   :m "H-C-l" #'evil-window-right
   :m "C-l"  #'comint-clear-buffer))
