;;; company

(use-package company
  :init
  (global-company-mode)

  :config
  (load (expand-file-name "company-keybind.el" my/elisp-dir))

  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 2)

  ;; config from centaur-emacs/doom-emacs
  (setq company-tooltip-align-annotations t)
  ;; (setq company-tooltip-limit 12) ; default 10
  (setq company-echo-delay (if (display-graphic-p) nil 0)) ; default nil
  ;; (setq company-require-match nil) ; default 'never (or 'company-explicit-action)
  ;; (setq company-dabbrev-ignore-case nil)  ; default 'keep-prefix
  ;; (setq company-dabbrev-downcase nil)
  ;; (setq company-global-modes '(not erc-mode message-mode help-mode gud-mode eshell-mode shell-mode))

  ;; frontends
  (setq company-frontends
        '(
          ;; company-pseudo-tooltip-unless-just-one-frontend ; default enabled
          company-pseudo-tooltip-frontend
          ;; company-preview-if-just-one-frontend ; default enabled
          company-echo-metadata-frontend ; default enabled
          ))

  ;; TODO change backends based on major-mode
  ;; (setq company-backends '(company-capf))

  ;; Ignore case
  (setq completion-ignore-case t)
  (setq read-file-name-completion-ignore-case t)
  (setq read-buffer-completion-ignore-case t))

(use-package company-quickhelp
  :init
  (setq company-quickhelp-delay 0.5))

(use-package company-box :disabled t
  :after (company)

  :hook
  (company-mode . company-box-mode)

  :init
  (setq company-box-icons-alist 'company-box-icons-all-the-icons) ; default company-box-icons-images
  ;; (setq company-box-backends-colors nil)
  (setq company-box-show-single-candidate t) ; default nil

  (setq company-box-enable-icon t)
  ;; A big number might slowndown the rendering.
  (setq company-box-max-candidates 50) ; default 100
  (setq company-box-doc-enable nil) ; default t
  (setq company-box-doc-delay 0.5) ; default 0.5

  :config
  ;; ported from centaur-emacs
  (with-no-warnings
    ;; Highlight `company-common'
    (defun my/company-box--make-line (candidate)
      (-let* (((candidate annotation len-c len-a backend) candidate)
              (color (company-box--get-color backend))
              ((c-color a-color i-color s-color) (company-box--resolve-colors color))
              (icon-string (and company-box--with-icons-p (company-box--add-icon candidate)))
              (candidate-string (concat (propertize (or company-common "") 'face 'company-tooltip-common)
                                        (substring (propertize candidate 'face 'company-box-candidate)
                                                   (length company-common) nil)))
              (align-string (when annotation
                              (concat
                               " "
                               (and company-tooltip-align-annotations
                                    (propertize " "
                                                'display
                                                `(space :align-to (- right-fringe ,(or len-a 0) 1)))))))
              (space company-box--space)
              (icon-p company-box-enable-icon)
              (annotation-string (and annotation (propertize annotation 'face 'company-box-annotation)))
              (line (concat (unless (or (and (= space 2) icon-p) (= space 0))
                              (propertize " " 'display `(space :width ,(if (or (= space 1) (not icon-p)) 1 0.75))))
                            (company-box--apply-color icon-string i-color)
                            (company-box--apply-color candidate-string c-color)
                            align-string
                            (company-box--apply-color annotation-string a-color)))
              (len (length line)))
        (add-text-properties 0 len (list 'company-box--len (+ len-c len-a)
                                         'company-box--color s-color)
                             line)
        line))
    (advice-add #'company-box--make-line :override #'my/company-box--make-line)

    ;; Prettify icons
    (defun my/company-box-icons--elisp (candidate)
      (when (derived-mode-p 'emacs-lisp-mode)
        (let ((sym (intern candidate)))
          (cond ((fboundp sym) 'Function)
                ((featurep sym) 'Module)
                ((facep sym) 'Color)
                ((boundp sym) 'Variable)
                ((symbolp sym) 'Text)
                (t . nil)))))
    (advice-add #'company-box-icons--elisp :override #'my/company-box-icons--elisp))

  (with-eval-after-load 'all-the-icons
    (declare-function all-the-icons-faicon 'all-the-icons)
    (declare-function all-the-icons-fileicon 'all-the-icons)
    (declare-function all-the-icons-material 'all-the-icons)
    (declare-function all-the-icons-octicon 'all-the-icons)
    (setq company-box-icons-all-the-icons
          `((Unknown . ,(all-the-icons-material "find_in_page" :height 0.85 :v-adjust -0.15))
            (Text . ,(all-the-icons-faicon "text-width" :height 0.8 :v-adjust -0.02))
            (Method . ,(all-the-icons-faicon "cube" :height 0.85 :v-adjust -0.02 :face 'all-the-icons-purple))
            (Function . ,(all-the-icons-faicon "cube" :height 0.85 :v-adjust -0.02 :face 'all-the-icons-purple))
            (Constructor . ,(all-the-icons-faicon "cube" :height 0.85 :v-adjust -0.02 :face 'all-the-icons-purple))
            (Field . ,(all-the-icons-octicon "tag" :height 0.9 :v-adjust 0 :face 'all-the-icons-lblue))
            (Variable . ,(all-the-icons-octicon "tag" :height 0.9 :v-adjust 0 :face 'all-the-icons-lblue))
            (Class . ,(all-the-icons-material "settings_input_component" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-orange))
            (Interface . ,(all-the-icons-material "share" :height 0.85 :v-adjust -0.15 :face 'all-the-icons-lblue))
            (Module . ,(all-the-icons-material "view_module" :height 0.85 :v-adjust -0.15 :face 'all-the-icons-lblue))
            (Property . ,(all-the-icons-faicon "wrench" :height 0.8 :v-adjust -0.02))
            (Unit . ,(all-the-icons-material "settings_system_daydream" :height 0.85 :v-adjust -0.15))
            (Value . ,(all-the-icons-material "format_align_right" :height 0.85 :v-adjust -0.15 :face 'all-the-icons-lblue))
            (Enum . ,(all-the-icons-material "storage" :height 0.85 :v-adjust -0.15 :face 'all-the-icons-orange))
            (Keyword . ,(all-the-icons-material "filter_center_focus" :height 0.85 :v-adjust -0.15))
            (Snippet . ,(all-the-icons-material "format_align_center" :height 0.85 :v-adjust -0.15))
            (Color . ,(all-the-icons-material "palette" :height 0.85 :v-adjust -0.15))
            (File . ,(all-the-icons-faicon "file-o" :height 0.85 :v-adjust -0.02))
            (Reference . ,(all-the-icons-material "collections_bookmark" :height 0.85 :v-adjust -0.15))
            (Folder . ,(all-the-icons-faicon "folder-open" :height 0.85 :v-adjust -0.02))
            (EnumMember . ,(all-the-icons-material "format_align_right" :height 0.85 :v-adjust -0.15))
            (Constant . ,(all-the-icons-faicon "square-o" :height 0.85 :v-adjust -0.1))
            (Struct . ,(all-the-icons-material "settings_input_component" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-orange))
            (Event . ,(all-the-icons-octicon "zap" :height 0.85 :v-adjust 0 :face 'all-the-icons-orange))
            (Operator . ,(all-the-icons-material "control_point" :height 0.85 :v-adjust -0.15))
            (TypeParameter . ,(all-the-icons-faicon "arrows" :height 0.8 :v-adjust -0.02))
            (Template . ,(all-the-icons-material "format_align_left" :height 0.85 :v-adjust -0.15)))
          company-box-icons-alist 'company-box-icons-all-the-icons)))

(use-package company-posframe :disabled
  :after
  (company)

  :hook
  (company-mode . company-posframe-mode))

(use-package company-dict :disabled t
  :config
  (add-to-list 'company-backends 'company-dict)
  (setq company-dict-dir (concat user-emacs-directory "dict/")))

(use-package prescient
  :config
  (setq prescient-save-file
        (expand-file-name "prescient-save.el" my/cache-dir)))

(use-package company-prescient
  :after
  (company prescient)

  :hook
  (company-mode . company-prescient-mode)
  (company-prescient-mode . prescient-persist-mode))
