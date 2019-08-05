(require 'dash)
(require 's)
(require 'cl-lib)

;; Dislay size
(defun my-funs/get-display-size (index)
  "Get display size by index."
  (let* ((attrs (display-monitor-attributes-list))
	 (disp (nth index attrs))
	 (size (assq 'geometry disp)))
    ;; (x-size . y-size)
    (cons (nth 3 size) (nth 4 size))))

;; Display setting
(cl-defun my-funs/get-display-setting-str ()
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

;; ivy-rich icons for buffer
;; FIXME Adjust icon height
(defun my-funs/ivy-rich-buffer-icon (candidate)
  (with-current-buffer (get-buffer candidate)
    (let ((icon (all-the-icons-icon-for-mode major-mode :height 1.1)))
      (when (symbolp icon)
        (setq icon (all-the-icons-icon-for-mode 'fundamental-mode :height 1.1)))
      (format "%s\t" icon))))

;; ivy-rich icons for file
;; FIXME Change folder icons
(defun my-funs/ivy-rich-file-icon (candidate)
  (let ((icon (all-the-icons-icon-for-file candidate)))
    (when (equal icon "")
      (setq icon (all-the-icons-icon-for-mode 'fundamental-mode)))
    (format "%s\t" icon)))

;; R assignment
(defun my-funs/insert-R-assign ()
  "Insert <-"
  (interactive)
  (just-one-space 1)
  (insert "<-")
  (just-one-space 1))

;; R pipe
(defun my-funs/insert-R-pipe ()
  "Insert %>%"
  (interactive)
  (just-one-space 1)
  (insert "%>%")
  (reindent-then-newline-and-indent))

(defun my-funs/activate-ime ()
  "Activate IME"
  (interactive)
  (unless current-input-method (toggle-input-method)))

(defun my-funs/toggle-ime ()
  "Toggle IME"
  (interactive)
  (toggle-input-method))

(defun my-funs/deactivate-ime ()
  "Deactivate IME"
  (interactive)
  (when current-input-method
    (evil-deactivate-input-method)
    (deactivate-input-method)))

;; Latin and Greek char's fonts
(defun my-funs/set-latin-greek-fonts (fontset font-name)
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

(defun my-funs/tabbar-buffer-list ()
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
