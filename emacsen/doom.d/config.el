;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; presets
(progn
  ;; Some functionality uses this to identify you, e.g. GPG configuration, email
  ;; clients, file templates and snippets.
  (setq user-full-name "John Doe"
        user-mail-address "john@doe.com")

  ;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
  ;; are the three important ones:
  ;;
  ;; + `doom-font'
  ;; + `doom-variable-pitch-font'
  ;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
  ;;   presentations or streaming.
  ;;
  ;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
  ;; font string. You generally only need these two:
  ;;
  (let ((num-disp (length (display-monitor-attributes-list)))
        (font-size 13)
        (big-font-size 19))
    ;; Larger font for high DPI Display
    (cond
     ;; mbp
     ((and (string= system-name "mbp1.local") (= num-disp 1))
      (setq font-size 19)
      (setq big-font-size 27))
     ;; x1
     ((and (string= system-name "x1") (= num-disp 1))
      (setq font-size 19)
      (setq big-font-size 27)))
    (setq doom-font (font-spec :family "Consolas NF" :size font-size))
    (setq doom-big-font (font-spec :family "Consolas NF" :size big-font-size))
    (setq doom-unicode-font (font-spec :family "MeiryoKe_Console" :size font-size))
    (add-to-list 'face-font-rescale-alist '(".*Meiryo*." . 1.09)
    ;; |abcdef ghijkl|
    ;; |ABCDEF GHIJKL|
    ;; |'";:-+ =/\~`?|
    ;; |αβγδεζ ηθικλμ|
    ;; |ΑΒΓΔΕΖ ΗΘΙΚΛΜ|
    ;; |日本語 の美観|
    ;; |あいう えおか|
    ;; |アイウ エオカ|
    ;; |ｱｲｳｴｵｶ ｷｸｹｺｻｼ|
    ))

  ;; There are two ways to load a theme. Both assume the theme is installed and
  ;; available. You can either set `doom-theme' or manually load a theme with the
  ;; `load-theme' function. This is the default:
  (setq doom-theme 'doom-one)

  ;; If you use `org' and don't want your org files in the default location below,
  ;; change `org-directory'. It must be set before org loads!
  (setq org-directory "~/org/")

  ;; This determines the style of line numbers in effect. If set to `nil', line
  ;; numbers are disabled. For relative line numbers, set this to `relative'.
  (setq display-line-numbers-type nil)


  ;; Here are some additional functions/macros that could help you configure Doom:
  ;;
  ;; - `load!' for loading external *.el files relative to this one
  ;; - `use-package' for configuring packages
  ;; - `after!' for running code after a package has loaded
  ;; - `add-load-path!' for adding directories to the `load-path', relative to
  ;;   this file. Emacs searches the `load-path' when you load packages with
  ;;   `require' or `use-package'.
  ;; - `map!' for binding new keys
  ;;
  ;; To get information about any of these functions/macros, move the cursor over
  ;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
  ;; This will open documentation for it, including demos of how they are used.
  ;;
  ;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
  ;; they are implemented.
  )

;; load private libraries
(progn
  (load (expand-file-name "~/Dropbox/repos/github/five-dots/dotfiles/emacsen/elisp/const.el"))
  (load (expand-file-name "const-secret.el" my/elisp-dir))
  (load (expand-file-name "vars.el" my/elisp-dir))
  (load (expand-file-name "funcs.el" my/elisp-dir)))


;;; core

;; TODO change recentf-save-file
;; TODO need exec-path-from-shell ?

(use-package! recentf-ext)


;;; input

(use-package! ddskk
  :disabled
  :after evil
  :defer t
  :commands skk-mode

  :hook
  ;; Always start using latin mode
  (evil-insert-state-entry . skk-mode)
  (skk-mode . skk-latin-mode-on)

  :init
  (setq default-input-method "japanese-skk")

  :config
  ;; Henkan candidates
  (setq skk-show-inline t)
  ;; Cursor color
  (setq skk-cursor-hiragana-color "yellow")
  (setq skk-cursor-katakana-color "blue violet")

  ;; Record file
  (setq skk-record-file "~/Dropbox/skk/record")
  ;; Personal jisyo
  (setq skk-jisyo "~/Dropbox/skk/jisyo/skk-jisyo")
  (setq skk-backup-jisyo "~/Dropbox/skk/jisyo/skk-jisyo.bak")
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

  ;; Disable skk mode when entering normal state
  (add-hook 'evil-normal-state-entry-hook
            '(lambda () (when skk-mode (skk-mode -1))))
  ;; suppress message "saving skk jisyo ... done"
  ;; http://slackwareirregulars.blogspot.com/2018/03/skk.html
  (defun skk-save-jisyo (&optional quiet)
    (interactive "P")
    (funcall skk-save-jisyo-function 'quiet)))

(use-package! mozc
  :init
  (setq default-input-method "japanese-mozc")

  :hook
  (evil-insert-state-exit . my/deactivate-ime)

  :config
  (map! :i [muhenkan] #'toggle-input-method)

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


;;; completion

(after! company
  (setq company-idle-delay 0.1)
  (setq company-show-numbers t)

  ;; ignore case
  (setq completion-ignore-case t)
  (setq read-file-name-completion-ignore-case t)
  (setq read-buffer-completion-ignore-case t)

  ;; NOTE config from centaur-emacs/doom-emacs
  ;; (setq company-tooltip-align-annotations t)
  ;; (setq company-tooltip-limit 12) ; default 10
  ;; (setq company-echo-delay (if (display-graphic-p) nil 0))
  ;; (setq company-require-match nil) ; default 'never (or 'company-explicit-action)
  ;; (setq company-dabbrev-ignore-case nil)  ; default 'keep-prefix
  ;; (setq company-dabbrev-downcase nil)
  ;; (setq company-global-modes '(not erc-mode message-mode help-mode gud-mode eshell-mode shell-mode))

  ;; set company backends (non-lsp)
  ;; (set-company-backend! 'emacs-lisp-mode
  ;;   '(company-capf company-files :with company-yasnippet))
  ;; (set-company-backend! 'org-mode
  ;;   '(company-dabbrev company-files company-yasnippet))
  ;; (when (featurep! :lang ess)
  ;;   (set-company-backend! 'ess-r-mode
  ;;     '(company-capf company-files company-yasnippet)))
  ;; (set-company-backend! 'stan-mode
  ;;   '(company-stan-backend company-files company-yasnippet))
  )

;; TODO show quickhelp manually (maybe popup setting is related)
(use-package! company-quickhelp :disabled
  :hook
  (company-mode . company-quickhelp-mode)

  :init
  (setq company-quickhelp-delay nil))

(after! company-lsp
  ;; NOTE should use use-package! and `:init' ?
  (setq +lsp-company-backend
        '(company-lsp company-files :with company-yasnippet)))

(use-package! all-the-icons-ivy-rich
  ;; Better experience with icons
  ;; Enable it before`ivy-rich-mode' for better performance
  ;; https://github.com/seagle0128/all-the-icons-ivy-rich

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
            (ivy-rich-counsel-function-docstring (:width 54 :face font-lock-doc-face)))))
        (variable-trans
         '(:columns
           ((all-the-icons-ivy-rich-variable-icon)
            (counsel-M-x-transformer (:width 50))
            (ivy-rich-counsel-function-docstring (:width 54 :face font-lock-doc-face)))))
        (recentf-trans
         '(:columns
           ((all-the-icons-ivy-rich-file-icon)
            (counsel-buffer-or-recentf-transformer))
           :delimiter "\t")))
    ;; switch-buffer
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'ivy-switch-buffer switch-buffer-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'ivy-switch-buffer-other-window switch-buffer-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-switch-buffer switch-buffer-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-switch-buffer-other-window switch-buffer-trans)
    ;; describe
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-M-x function-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-describe-function function-trans)
    ;; describe
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-describe-variable variable-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-set-variable variable-trans)
    ;; recentf
    ;; TODO trancate long path string into one line
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-recentf recentf-trans)
    (plist-put all-the-icons-ivy-rich-display-transformers-list
               'counsel-buffer-or-recentf recentf-trans)))

(after! ivy
  (setq ivy-height 10)
  (setq ivy-use-virtual-buffers t)

  ;; TODO change `counsel-yank-pop' value (not add newly)
  (add-to-list 'ivy-height-alist
               '(counsel-yank-pop . 15)))

(after! ivy-posframe
  (setq ivy-posframe-border-width 1)
  (setq ivy-posframe-width 110)
  (setq ivy-posframe-min-width 110)
  (setq ivy-posframe-min-height 10)
  (setq ivy-posframe-height 10)
  (setq ivy-posframe-parameters
        '((left-fringe  . 5) (right-fringe . 5)))

  ;; Per command settings
  (setq ivy-posframe-display-functions-alist
        '((swiper . ivy-display-function-fallback)
          (swiper-all . ivy-display-function-fallback)
          (counsel-rg . ivy-display-function-fallback)
          (counsel-yank-pop . ivy-display-function-fallback)
          (counsel-git-grep . ivy-display-function-fallback)
          (counsel-grep . ivy-display-function-fallback)
          (t . ivy-posframe-display-at-frame-center)))

  ;; Per command height settings
  (setq ivy-posframe-height-alist
        '((swiper . 20)
          (swiper-all . 20)
          (counsel-rg . 20)
          (counsel-yank-pop . 20)
          (counsel-git-grep . 20)
          (counsel-grep . 20)
          (t . 10)))

  (set-face-attribute 'ivy-posframe nil :background "#282a36")
  (set-face-attribute 'ivy-posframe-border nil :background "#6272a4")
  (set-face-attribute 'ivy-posframe-cursor nil :background "#61bfff"))

(after! counsel
  (setq counsel-yank-pop-separator "\n--------------------\n"))


;;; ui

(after! doom-themes
  (setq doom-themes-treemacs-theme "doom-atom") ; "doom-atom" or "Default"
  (setq doom-themes-treemacs-enable-variable-pitch nil))

(after! treemacs
  (map!
   [remap +treemacs/toggle] #'treemacs)

  ;; TODO enable hl-line-mode
  (setq treemacs-show-cursor t)
  (setq treemacs-position 'right)
  (treemacs-resize-icons 18))

(use-package! page-break-lines
  :config
  (add-to-list 'page-break-lines-modes 'ess-r-mode)
  (add-to-list 'page-break-lines-modes 'python-mode)
  (global-page-break-lines-mode))

;; frame-size
(when (display-graphic-p)
  (set-frame-size (selected-frame) 120 50))


;;; editor

(after! yasnippet
  (add-to-list 'yas-snippet-dirs my/snippets-dir))


;;; checkers

(after! flycheck
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


;;; tools

(when (featurep! :ui popup)
  (set-popup-rules!
    '(
      ;; NOTE Available options
      ;; :ignore BOOL
      ;; :actions ACTIONS
      ;; :side 'bottom|'top|'left|'right
      ;; :size/:width/:height FLOAT|INT|FN
      ;; :slot/:vslot INT (use with :side and blank :action)
      ;; :ttl INT|BOOL|FN
      ;; :quit FN|BOOL|'other|'current
      ;; :select BOOL|FN
      ;; :modeline BOOL|FN|LIST
      ;; :autosave BOOL|FN
      ;; :parameters ALIST

      ;; ("^\\*[Hh]elp" :side right :size 81 :select t :quite current)

      ;;; ESS
      ("^\\*R dired" :ignore t)
      ("^\\*R" :ignore t)
      ("^\\*ess-describe\\*$" :ignore t) ; ess-describe-object-at-point
      ("^\\*help\\[R\\](" :side right :size 81 :select t :quit current)
      ("^\\*R view\\*$" :side bottom :size 0.5 :quit t) ; view var from r-dired

      ("^\\*General Keybindings\\*$" :ignore t)
      ("^\\*lsp session\\*$" :ignore t)
      ;; TODO company-diag
      ;; TODO google-translate
      ;; TODO company-doc
      )))


;;; lang

(use-package! org
  ;; :hook
  ;; (org-mode . visual-line-mode)
  ;; (org-babel-after-execute . my/org-redisplay-inline-images)

  :config
  ;; Replace "-" with "•"
  (font-lock-add-keywords
   'org-mode
   '(("^ *\\([-]\\) "
      (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (setq org-hide-emphasis-markers t)
  ;; faces
  (set-face-attribute 'org-level-1 nil :slant 'italic :height 1.0)
  ;; (set-face-attribute 'org-block-end-line nil :foreground "#23272e")

  ;;; org-agenda
  ;; Add agenda file recursively
  ;; (setq org-agenda-files
  ;; (apply 'append
  ;;         (mapcar (lambda (directory)
  ;;       (directory-files-recursively directory org-agenda-file-regexp))
  ;;           '("~/Dropbox/memo"))))
  ;; agenda format
  ;; (setq org-agenda-prefix-format
  ;;       (quote
  ;;        ((agenda . " %i %-12:c%?12t% s")
  ;;         (todo   . " %i %-12:c")
  ;;         (tags   . " %i %-12:c")
  ;;         (search . " %i %-12:c"))))
  ;; (set-face-attribute 'org-block-end-line nil :foreground "#23272e")

  ;; Latex preview
  ;; (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-preview-latex-image-directory "~/Dropbox/memo/img/latex/"))

(after! org-bullets
  (setq org-bullets-bullet-list '("" "" "" "" "" "" "" "" "" "")))

(after! ess
  (setq ess-offset-continued '(straight . 2)) ; or '(cascade . 2)
  (setq ess-eldoc-show-on-symbol t)
  (setq ess-history-file nil)
  (setq ess-use-R-completion nil)
  (setq ess-use-auto-complete nil)
  (setq ess-use-ido nil)

  ;; object popup by tooltip
  (setq ess-describe-at-point-method nil)
  (setq x-gtk-use-system-tooltips nil)
  (setq tooltip-hide-delay 10)
  ;; TODO colored str by {crayon}
  (setq ess-R-describe-object-at-point-commands
        '(("str(%s)")
          (".ess_htsummary(%s, hlength = 20, tlength = 20)")
          ("summary(%s, maxsum = 20)")))

  (set-evil-initial-state! 'inferior-ess-r-mode 'normal)
  ;; (evil-define-key 'normal ctbl:table-mode-map
  ;;   "q" 'kill-this-buffer)

  ;;; ESS related buffers
  ;; inferior-ess-r-mode *R*
  ;; ess-dired-mode *R dired*
  ;; TODO ess-watch-mode  *R watch*
  ;; fundamental-mode *ess-describe* (popup)
  ;; fundamental-mode *R view* (by popup)
  (defun my/set-ess-display-buffer-alist ()
    (interactive)
    (dolist (l '(
                 ("^\\*R"
                  (display-buffer-reuse-window display-buffer-in-side-window)
                  (side . left)
                  (reusable-frames . nil))
                 ("^\\*R dired"
                  (display-buffer-reuse-window display-buffer-in-side-window)
                  (side . right)
                  (slot . -1)
                  (window-width . 0.2)
                  (reusable-frames . nil))
                 ("^\\*ess-describe"
                  (display-buffer-reuse-window display-buffer-same-window)
                  (reusable-frames . nil))
                 ))
      (add-to-list 'display-buffer-alist l)))
  (add-hook 'ess-r-mode-hook #'my/set-ess-display-buffer-alist)

  ;; TODO Complete hydra map for ess-tracebug
  (defhydra hydra-ess-tracebug (:color pink :hint nil)
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
    ("q" nil "Close" :color blue)))

;; TODO ess-smart-equals

(use-package! ess-r-spreadsheet
  :after
  (:any ess-r-mode inferior-ess-r-mode ess-r-transcript)

  :commands
  (ess-r-spreadsheet))

(use-package! stan-mode
  :mode ("\\.stan\\'" . stan-mode)
  :hook (stan-mode . stan-mode-setup)
  ;; company
  :init
  (use-package! company-stan
    :load-path ".local/straight/repos/stan-mode/company-stan"
    :hook (stan-mode . company-stan-setup)
    :config
    (setq company-stan-fuzzy nil))
  :config
  (setq stan-indentation-offset 2)
  ;; Add snippets dir
  (add-to-list
   'yas-snippet-dirs
   (expand-file-name
    "straight/repos/stan-mode/stan-snippets/snippets"
    doom-local-dir)))

(when (featurep! :lang python)
  ;; (add-to-list 'python-shell-completion-native-disabled-interpreters "python3")
  ;; (setq python-shell-interpreter-args "-i")
  (setq org-babel-python-command "python3")

  ;; https://github.com/jorgenschaefer/elpy/issues/733
  (setq python-shell-prompt-detect-enabled nil)
  (setq python-shell-prompt-detect-failure-warning nil))

(use-package! dotnet
  :hook
  (csharp-mode . dotnet-mode))

(use-package! crontab-mode
  :mode (("\\.cron\\(tab\\)?\\'" . crontab-mode)
         ("cron\\(tab\\)?\\." . crontab-mode)))


;;; keybindings

;; TODO prefix: g, z, [, ], @(macro)

;; global
(map!
 :nv "H"  #'evil-first-non-blank-of-visual-line
 :nv "J"  #'evil-forward-paragraph
 :nv "K"  #'evil-backward-paragraph
 :nv "L"  #'evil-end-of-visual-line
 :nv "j"  #'evil-next-visual-line
 :nv "k"  #'evil-previous-visual-line
 :nv "gj" #'evil-next-line
 :nv "gk" #'evil-previous-line
 :n "C-M-h" #'evil-window-left
 :n "C-M-j" #'evil-window-down
 :n "C-M-k" #'evil-window-up
 :n "C-M-l" #'evil-window-right)

;; leader
(map!
 :leader
 :desc "M-x"                   "SPC" #'execute-extended-command
 :desc "Project sidebar"       "0"   #'+treemacs/toggle
 :desc "Switch buffer"         ","   #'switch-to-buffer
 :desc "Switch to last buffer" "TAB" #'evil-switch-to-windows-last-buffer
 :desc "Resume last search"    "."
 (cond ((featurep! :completion ivy) #'ivy-resume)
       ((featurep! :completion helm) #'helm-resume))
 ;; workspace
 (:when (featurep! :ui workspaces)
   :desc "Switch workspace buffer" "<" #'persp-switch-to-buffer
   :desc "Switch buffer" "," #'switch-to-buffer
   (:prefix-map ("W" . "workspace")
     :desc "Display tab bar"           "TAB" #'+workspace/display
     :desc "Switch workspace"          "."   #'+workspace/switch-to
     :desc "Switch to last workspace"  "`"   #'+workspace/other
     :desc "New workspace"             "n"   #'+workspace/new
     :desc "Load workspace from file"  "l"   #'+workspace/load
     :desc "Save workspace to file"    "s"   #'+workspace/save
     :desc "Delete session"            "x"   #'+workspace/kill-session
     :desc "Delete this workspace"     "d"   #'+workspace/delete
     :desc "Rename workspace"          "r"   #'+workspace/rename
     :desc "Restore last session"      "R"   #'+workspace/restore-last-session
     :desc "Next workspace"            "]"   #'+workspace/switch-right
     :desc "Previous workspace"        "["   #'+workspace/switch-left
     :desc "Switch to 1st workspace"   "1"   #'+workspace/switch-to-0
     :desc "Switch to 2nd workspace"   "2"   #'+workspace/switch-to-1
     :desc "Switch to 3rd workspace"   "3"   #'+workspace/switch-to-2
     :desc "Switch to 4th workspace"   "4"   #'+workspace/switch-to-3
     :desc "Switch to 5th workspace"   "5"   #'+workspace/switch-to-4
     :desc "Switch to 6th workspace"   "6"   #'+workspace/switch-to-5
     :desc "Switch to 7th workspace"   "7"   #'+workspace/switch-to-6
     :desc "Switch to 8th workspace"   "8"   #'+workspace/switch-to-7
     :desc "Switch to 9th workspace"   "9"   #'+workspace/switch-to-8
     :desc "Switch to final workspace" "0"   #'+workspace/switch-to-final))
 ":" nil
 "'" nil
 "`" nil
 ;; google search
 (:prefix-map ("/ g " . "google")
   "g" #'google-this
   "t" #'google-translate-at-point
   "T" #'google-translate-at-point-reverse
   "q" #'google-translate-query-translate
   "Q" #'google-translate-query-translate-reverse))

;; company
(map!
 ;; NOTE +company commands
 ;; (+company/dabbrev)
 ;; (+company/complete)
 ;; (+company/whole-lines)
 ;; (+company/dict-or-keywords)
 ;; (+company/dabbrev-code-previous)
 ;; (+company/toggle-auto-completion)

 (:after company
   :i "M-," #'+company/complete
   (:map company-active-map
     "C-SPC" #'company-complete-common
     "<tab>" #'company-complete-selection
     "M-."   #'company-filter-candidates
     "M-/"   #'company-search-candidates
     "M-d"   #'company-next-page
     "M-u"   #'company-previous-page
     "M-i"   #'company-show-doc-buffer
     "M-p"   #'company-quickhelp-manual-begin
     "M-w"   #'company-show-location
     "M-c"   #'counsel-company
     )))

;; treemacs
(map!
 (:when (featurep! :ui treemacs)
   (:map treemacs-mode-map
     "C-M-h" #'evil-window-left
     "C-M-j" #'evil-window-down
     "C-M-k" #'evil-window-up
     "C-M-l" #'evil-window-right)))

;; evil-window-map
(map!
 (:map evil-window-map
   "d" #'evil-quit
   "m" #'ace-swap-window
   "O" #'delete-other-windows
   "w" #'ace-window
   "W" #'ace-delete-window
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

;; emacs-lisp-mode-map
(map!
 :localleader
 (:map emacs-lisp-mode-map
   :nv "h" #'helpful-at-point
   (:prefix-map ("e" . "eval")
     :nv "b" #'eval-buffer
     :nv "e" #'eval-last-sexp
     :nv "f" #'eval-defun
     :nv "r" #'eval-region
     :nv "x" #'lispxmp)))

;; org-mode-map
;; TODO complete keymap
(map!
 (:after org
   :localleader
   (:map org-mode-map
     "," #'org-ctrl-c-ctrl-c)))

;; ddskk
(map!
 (:after skk
   :i "C-j" nil ; disable +default/newline
   (:map skk-latin-mode-map
     [muhenkan] #'skk-kakutei)))

;; mozc
(map!
 (:after mozc
   :i [muhenkan] #'toggle-input-method
   :i [henkan] #'my/deactivate-ime))

;; ess
;; TODO ess-watch-mode-map, ess-describe-mode and others
(map!
 (:after ess
   (:map ess-dev-map
     "."   #'hydra-ess-tracebug/body
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
     "TAB" nil
     "C-d" nil
     "C-e" nil
     "C-l" nil
     "C-r" nil
     "C-s" nil
     "C-t" nil
     "C-w" nil)

   (:map ess-doc-map
     "RET" nil
     "TAB" nil
     [C-return] nil
     [down] nil
     [up] nil
     "C-a" nil
     "C-d" nil
     "C-e" nil
     "C-o" nil
     "C-v" nil
     "C-w" nil
     "d" nil
     "m" nil
     "p" nil
     "t" nil)

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
       "C-u" nil)

   (:map inferior-ess-r-mode-map
     :i "," #'ess-smart-comma)

   :nv "<C-return>" nil ; disable +default/newline-below
   :i "C->" #'my/insert-R-pipe
   :localleader
   (:map ess-r-mode-map
     ","   #'ess-eval-region-or-function-or-paragraph
     "."   #'ess-describe-object-at-point
     "TAB" #'ess-switch-to-inferior-or-script-buffer

     ;; predefined map
     "d" #'ess-dev-map           ; d=debug
     "e" #'ess-extra-map         ; e=eval
     "h" #'ess-doc-map           ; h=help
     "p" #'ess-r-package-dev-map ; p=package-dev
     "v" nil                     ; v=view
     "x" nil

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
     "R" nil

     (:prefix ("c" . "chunk"))
     (:prefix ("d" . "debug"))
     (:prefix ("e" . "eval"))
     (:prefix ("h" . "help"))
     (:prefix ("p" . "package-dev"))
     (:prefix ("pc" . "check"))
     (:prefix ("s" . "show")
       "p" #'ess-R-dv-pprint
       "t" #'ess-R-dv-ctable
       "s" #'ess-r-spreadsheet
       ))

   :localleader
   (:map inferior-ess-r-mode-map
     ","   #'ess-smart-comma
     "."   #'ess-describe-object-at-point
     "TAB" #'ess-switch-to-inferior-or-script-buffer))

 (:after ess-help
   :map ess-r-help-mode-map
   :n "J" #'ess-skip-to-next-section
   :n "K" #'ess-skip-to-previous-section
   :n "W" #'ess-display-help-in-browser))

;; comint-mode
(map!
 (:map comint-mode-map
   :n "C-M-h" #'evil-window-left
   :n "C-M-j" #'evil-window-down
   :n "C-M-k" #'evil-window-up
   :n "C-M-l" #'evil-window-right
   :ni "C-l"  #'comint-clear-buffer))

;; omnisharp
;; TODO omnisharp ではなく LSP が優先されているためうまく動かない
(map!
 (:after omnisharp
   :localleader
   (:map omnisharp-mode-map
     (:prefix ("g" . "goto"))
     (:prefix ("r" . "refactor"))
     (:prefix ("t" . "test")))))

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
       :n "r" #'dotnet-sln-remove))))
