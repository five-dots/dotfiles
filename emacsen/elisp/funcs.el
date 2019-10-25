
(require 'dash)
(require 's)
(require 'f)
(require 'cl-lib)



(defun my/switch-to-scratch-buffer ()
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*"))
  (funcall 'lisp-interaction-mode))

(defun my/alternate-buffer (&optional window)
  "Switch back and forth between current and last buffer in the
current window.
If `spacemacs-layouts-restrict-spc-tab' is `t' then this only switches between
the current layouts buffers."
  (interactive)
  (destructuring-bind (buf start pos)
      (if spacemacs-layouts-restrict-spc-tab
          (let ((buffer-list (persp-buffer-list))
                (my-buffer (window-buffer window)))
            ;; find buffer of the same persp in window
            (seq-find (lambda (it) ;; predicate
                        (and (not (eq (car it) my-buffer))
                             (member (car it) buffer-list)))
                      (window-prev-buffers)
                      ;; default if found none
                      (list nil nil nil)))
        (or (cl-find (window-buffer window) (window-prev-buffers)
                     :key #'car :test-not #'eq)
            (list (other-buffer) nil nil)))
    (if (not buf)
        (message "Last buffer not found.")
      (set-window-buffer-start-and-point window buf start pos))))

(defun my/search-dir (&optional arg)
  "Conduct a text search in files under the current folder.
If prefix ARG is set, prompt for a directory to search from."
  (interactive "P")
  (let ((default-directory
          (if arg (read-directory-name "Search directory: ")
            default-directory)))
    (funcall 'counsel-rg nil default-directory)))

(defun my/search-other-dir ()
  "Conduct a text search in another directory."
  (interactive)
  (my/search-dir 'other))


;;; display, ui

;; Dislay size
(defun my/get-display-size (index)
  "Get display size by index."
  (let* ((attrs (display-monitor-attributes-list))
	       (disp (nth index attrs))
	       (size (assq 'geometry disp)))
    ;; (x-size . y-size)
    (cons (nth 3 size) (nth 4 size))))

;; Display setting
(cl-defun my/get-display-setting-str ()
  "Return display setting by string."
  (interactive)
  (let* ((attrs (display-monitor-attributes-list))
	 (count (length attrs)))
    ;; desk1
    (when (equal (system-name) "desk1")
      (return-from my-funs/get-disp-setting-str "desk1"))
    ;; x1
    (cond
     ((eq count 1) "x1-single")
     ;; x1 + Pao's LG (2560 x 1080)
     ((and (eq count 2) (equal (my-funs/get-display-size 1) '(2560 . 1080))) "x1+pao-lg")
     ;; x1 + unknown display
     (t "x1+unknown-disp"))))

;; Latin and Greek char's fonts
(defun my/set-latin-greek-fonts (fontset font-name)
  "Overwrite latin and greek char's fonts"
  (set-fontset-font fontset '(#x0250 . #x02AF) (font-spec :family font-name))
  (set-fontset-font fontset '(#x00A0 . #x00FF) (font-spec :family font-name))
  (set-fontset-font fontset '(#x0100 . #x017F) (font-spec :family font-name))
  (set-fontset-font fontset '(#x0180 . #x024F) (font-spec :family font-name))
  (set-fontset-font fontset '(#x2018 . #x2019) (font-spec :family font-name))
  (set-fontset-font fontset '(#x2588 . #x2588) (font-spec :family font-name))
  (set-fontset-font fontset '(#x2500 . #x2500) (font-spec :family font-name))
  (set-fontset-font fontset '(#x2504 . #x257F) (font-spec :family font-name))
  (set-fontset-font fontset '(#x0370 . #x03FF) (font-spec :family font-name)))

(defun my/tabbar-buffer-list ()
  (delq
   nil
   (mapcar #'(lambda (b)
               (cond
                ;; Always include the current buffer.
                ((eq (current-buffer) b) b)
                ((buffer-file-name b) b)
                ((char-equal ?\  (aref (buffer-name b) 0)) nil)
                ;; *scratch*バッファは表示する
                ;; ((equal "*scratch*" (buffer-name b)) b)
                ;; それ以外の * で始まるバッファは表示しない
                ((char-equal ?* (aref (buffer-name b) 0)) nil)
                ((buffer-live-p b) b)))
           (buffer-list))))


;;; ivy-rich

;; ivy-rich icons for buffer
;; FIXME Adjust icon height
(defun my/ivy-rich-buffer-icon (candidate)
  (with-current-buffer (get-buffer candidate)
    (let ((icon (all-the-icons-icon-for-mode major-mode :height 1.1)))
      (when (symbolp icon)
        (setq icon (all-the-icons-icon-for-mode 'fundamental-mode :height 1.1)))
      (format "%s\t" icon))))

;; ivy-rich icons for file
;; FIXME Change folder icons
(defun my/ivy-rich-file-icon (candidate)
  (let ((icon (all-the-icons-icon-for-file candidate)))
    (when (equal icon "")
      (setq icon (all-the-icons-icon-for-mode 'fundamental-mode)))
    (format "%s\t" icon)))


;;; ess

;; R pipe
(defun my/insert-R-pipe ()
  "Insert %>%."
  (interactive)
  (just-one-space 1)
  (insert "%>%")
  ;; (reindent-then-newline-and-indent)
  (just-one-space 1))


;;; ime

(defun my/deactivate-ime ()
  "Deactivate IME."
  (interactive)
  (when current-input-method
    (evil-deactivate-input-method)
    (deactivate-input-method)))


;;; org

;; Custom function to get ramdom file name
(cl-defun my/get-babel-file
    (&key
     (dir (expand-file-name "~/Dropbox/memo/img/babel/"))
     (prefix "fig-")
     (suffix ".png"))
  (concat dir (make-temp-name prefix) suffix))
(defalias 'get-babel-file 'my/get-babel-file)

;; Update inline images
(defun my/org-redisplay-inline-images ()
  (when org-inline-image-overlays
    (org-redisplay-inline-images)))


;;; company

(defun my/set-company-backend-for-r ()
  (interactive)
  (set (make-local-variable 'company-backends)
       '((company-capf
          ;; company-dabbrev
          company-files
          :with company-yasnippet))))

;; FIXME not enabled
(defun my/set-company-backend-for-el ()
  (interactive)
  (set (make-local-variable 'company-backends)
       '((company-capf
          company-files
          :with company-yasnippet))))

;; FIXME not enabled
(defun my/set-company-backend-for-org ()
  (interactive)
  (set (make-local-variable 'company-backends)
       '((company-dabbrev
          company-files
          company-yasnippet))))

(defun my/set-company-backend-for-stan ()
  (interactive)
  (set (make-local-variable 'company-backends)
       '((company-stan-backend
          company-dabbrev
          company-files
          :with company-yasnippet))))

;; FIXME not enabled
(defun my/set-company-backend-for-lsp ()
  (interactive)
  (set (make-local-variable 'company-backends)
       '((company-lsp
          company-dabbrev
          company-files
          :with company-yasnippet))))

;; Change fringe width mainly for dap-mode breakpoints
(defun my/change-fringe-width ()
  (setq left-fringe-width 15
        right-fringe-width 0))
