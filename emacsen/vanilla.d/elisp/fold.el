;;; fold: imported from doom-emacs' fold module

;; TODO automatically enable vimish-fold-mode

(defun my/doom-enlist (exp)
  "Return EXP wrapped in a list, or as-is if already a list."
  (declare (pure t) (side-effect-free t))
  (if (listp exp) exp (list exp)))

(defmacro my/defadvice (symbol arglist &optional docstring &rest body)
  "Define an advice called SYMBOL and add it to PLACES.

	ARGLIST is as in `defun'. WHERE is a keyword as passed to `advice-add', and
	PLACE is the function to which to add the advice, like in `advice-add'.
	DOCSTRING and BODY are as in `defun'.

	\(fn SYMBOL ARGLIST &optional DOCSTRING &rest [WHERE PLACES...] BODY\)"
  (declare (doc-string 3) (indent defun))
  (unless (stringp docstring)
	(push docstring body)
	(setq docstring nil))
  (let (where-alist)
	(while (keywordp (car body))
	  (push `(cons ,(pop body) (my/doom-enlist ,(pop body)))
			where-alist))
	`(progn
	   (defun ,symbol ,arglist ,docstring ,@body)
	   (dolist (targets (list ,@(nreverse where-alist)))
		 (dolist (target (cdr targets))
		   (advice-add target (car targets) #',symbol))))))

(defmacro my/undefadvice (symbol _arglist &optional docstring &rest body)
  "Undefine an advice called SYMBOL.

  This has the same signature as `my/defadvice' an exists as an easy undefiner when
  testing advice (when combined with `rotate-text').

  \(fn SYMBOL ARGLIST &optional DOCSTRING &rest [WHERE PLACES...] BODY\)"
  (declare (doc-string 3) (indent defun))
  (let (where-alist)
    (unless (stringp docstring)
    (push docstring body))
    (while (keywordp (car body))
    (push `(cons ,(pop body) (my/doom-enlist ,(pop body)))
        where-alist))
    `(dolist (targets (list ,@(nreverse where-alist)))
    (dolist (target (cdr targets))
      (advice-remove target #',symbol)))))

(defun my/fold--ensure-hideshow-mode ()
  (unless (bound-and-true-p hs-minor-mode)
    (hs-minor-mode +1)))

(defun my/fold--vimish-fold-p ()
  (and (featurep 'vimish-fold)
       (cl-some #'vimish-fold--vimish-overlay-p
                (overlays-at (point)))))

(defun my/fold--outline-fold-p ()
  (and (or (bound-and-true-p outline-minor-mode)
           (derived-mode-p 'outline-mode))
       (outline-on-heading-p)))

(defun my/fold--hideshow-fold-p ()
  (my/fold--ensure-hideshow-mode)
  (save-excursion
    (ignore-errors
      (or (hs-looking-at-block-start-p)
          (hs-find-block-beginning)
          (unless (eolp)
            (end-of-line)
            (my/fold--hideshow-fold-p))))))

(defun my/fold--invisible-points (count)
  (let (points)
    (save-excursion
      (catch 'abort
        (if (< count 0) (beginning-of-line))
        (while (re-search-forward hs-block-start-regexp nil t
                                  (if (> count 0) 1 -1))
          (unless (invisible-p (point))
            (end-of-line)
            (when (hs-already-hidden-p)
              (push (point) points)
              (when (>= (length points) count)
                (throw 'abort nil))))
          (forward-line (if (> count 0) 1 -1)))))
    points))

(defmacro my/fold-from-eol (&rest body)
  "Perform action after moving to the end of the line."
  `(save-excursion
     (end-of-line)
     ,@body))

;; Commands

;;;###autoload
(defun my/fold-toggle ()
  "Toggle the fold at point.

  Targets `vimmish-fold', `hideshow' and `outline' folds."
  (interactive)
  (save-excursion
    (cond ((my/fold--vimish-fold-p) (vimish-fold-toggle))
          ((my/fold--outline-fold-p)
           (cl-letf (((symbol-function #'outline-hide-subtree)
                      (symbol-function #'outline-hide-entry)))
             (outline-toggle-children)))
          ((my/fold--hideshow-fold-p) (my/fold-from-eol (hs-toggle-hiding))))))

;;;###autoload
(defun my/fold-open ()
  "Open the folded region at point.

  Targets `vimmish-fold', `hideshow' and `outline' folds."
  (interactive)
  (save-excursion
    (cond ((my/fold--vimish-fold-p) (vimish-fold-unfold))
          ((my/fold--outline-fold-p)
           (outline-show-children)
           (outline-show-entry))
          ((my/fold--hideshow-fold-p) (my/fold-from-eol (hs-show-block))))))

;;;###autoload
(defun my/fold-close ()
  "Close the folded region at point.

  Targets `vimmish-fold', `hideshow' and `outline' folds."
  (interactive)
  (save-excursion
    (cond ((my/fold--vimish-fold-p) (vimish-fold-refold))
          ((my/fold--hideshow-fold-p) (my/fold-from-eol (hs-hide-block)))
          ((my/fold--outline-fold-p) (outline-hide-subtree)))))

;;;###autoload
(defun my/fold-open-all (&optional level)
  "Open folds at LEVEL (or all folds if LEVEL is nil)."
  (interactive
   (list (if current-prefix-arg (prefix-numeric-value current-prefix-arg))))
  (when (featurep 'vimish-fold)
    (vimish-fold-unfold-all))
  (save-excursion
    (my/fold--ensure-hideshow-mode)
    (if (integerp level)
        (progn
          (outline-hide-sublevels (max 1 (1- level)))
          (hs-life-goes-on
           (hs-hide-level-recursive (1- level) (point-min) (point-max))))
      (hs-show-all)
      (when (fboundp 'outline-show-all)
        (outline-show-all)))))

;;;###autoload
(defun my/fold-close-all (&optional level)
  "Close folds at LEVEL (or all folds if LEVEL is nil)."
  (interactive
   (list (if current-prefix-arg (prefix-numeric-value current-prefix-arg))))
  (save-excursion
    (when (featurep 'vimish-fold)
      (vimish-fold-refold-all))
    (my/fold--ensure-hideshow-mode)
    (hs-life-goes-on
     (if (integerp level)
         (hs-hide-level-recursive (1- level) (point-min) (point-max))
       (hs-hide-all)))))

;;;###autoload
(defun my/fold-next (count)
  "Jump to the next vimish fold, outline heading or folded region."
  (interactive "p")
  (cl-loop with orig-pt = (point)
           for fn
           in (list (lambda ()
                      (when (bound-and-true-p hs-block-start-regexp)
                        (car (my/fold--invisible-points count))))
                    (lambda ()
                      (when (featurep 'vimish-fold)
                        (if (> count 0)
                            (evil-vimish-fold/next-fold count)
                          (evil-vimish-fold/previous-fold (- count))))
                      (if (/= (point) orig-pt) (point))))
           if (save-excursion (funcall fn))
           collect it into points
           finally do
           (if-let* ((pt (car (sort points (if (> count 0) #'< #'>)))))
               (goto-char pt)
             (message "No more folds %s point" (if (> count 0) "after" "before"))
             (goto-char orig-pt))))

;;;###autoload
(defun my/fold-previous (count)
  "Jump to the previous vimish fold, outline heading or folded region."
  (interactive "p")
  (my/fold-next (- count)))

(defface my/fold-hideshow-folded-face
	`((t (:inherit font-lock-comment-face :weight light)))
	"Face to hightlight `hideshow' overlays."
	:group 'doom-themes)

;;;###autoload
(defun my/fold-hideshow-haml-forward-sexp-fn (arg)
  (haml-forward-sexp arg)
  (move-beginning-of-line 1))

;;;###autoload
(defun my/fold-hideshow-forward-block-by-indent-fn (_arg)
  (let ((start (current-indentation)))
    (forward-line)
    (unless (= start (current-indentation))
      (let ((range (my/fold-hideshow-indent-range)))
        (goto-char (cadr range))
        (end-of-line)))))

;;;###autoload
(defun my/fold-hideshow-set-up-overlay-fn (ov)
  (when (eq 'code (overlay-get ov 'hs))
    (when (featurep 'vimish-fold)
      (overlay-put
       ov 'before-string
       (propertize "…" 'display
                   (list vimish-fold-indication-mode
                         'empty-line
                         'vimish-fold-fringe))))
    (overlay-put
     ov 'display (propertize "  [...]  " 'face 'my/fold-hideshow-folded-face))))

;; Indentation detection

(defun my/fold--hideshow-empty-line-p (_)
  (string= "" (string-trim (thing-at-point 'line 'no-props))))

(defun my/fold--hideshow-geq-or-empty-p (base-indent)
  (or (my/fold--hideshow-empty-line-p base-indent)
      (>= (current-indentation) base-indent)))

(defun my/fold--hideshow-g-or-empty-p (base-indent)
  (or (my/fold--hideshow-empty-line-p base-indent)
      (> (current-indentation) base-indent)))

(defun my/fold--hideshow-seek (start direction before skip predicate base-indent)
  "Seeks forward (if direction is 1) or backward (if direction is -1) from start, until predicate
  fails. If before is nil, it will return the first line where predicate fails, otherwise it returns
  the last line where predicate holds."
  (save-excursion
    (goto-char start)
    (goto-char (point-at-bol))
    (let ((bnd (if (> 0 direction)
                   (point-min)
                 (point-max)))
          (pt (point)))
      (when skip (forward-line direction))
      (cl-loop while (and (/= (point) bnd) (funcall predicate base-indent))
               do (progn
                    (when before (setq pt (point-at-bol)))
                    (forward-line direction)
                    (unless before (setq pt (point-at-bol)))))
      pt)))

(defun my/fold-hideshow-indent-range (&optional point)
  "Return the point at the begin and end of the text block with the same (or
  greater) indentation. If `point' is supplied and non-nil it will return the
  begin and end of the block surrounding point."
  (save-excursion
    (when point
      (goto-char point))
    (let ((base-indent (current-indentation))
          (begin (point))
          (end (point)))
      (setq begin (my/fold--hideshow-seek begin -1 t nil #'my/fold--hideshow-geq-or-empty-p base-indent)
            begin (my/fold--hideshow-seek begin 1 nil nil #'my/fold--hideshow-g-or-empty-p base-indent)
            end   (my/fold--hideshow-seek end 1 t nil #'my/fold--hideshow-geq-or-empty-p base-indent)
            end   (my/fold--hideshow-seek end -1 nil nil #'my/fold--hideshow-empty-line-p base-indent))
      (list begin end base-indent))))

(use-package hideshow
  :commands
  (hs-toggle-hiding hs-hide-block hs-hide-level hs-show-all hs-hide-all)

  :config
  (setq hs-hide-comments-when-hiding-all nil)
  ;; Nicer code-folding overlays (with fringe indicators)
  (setq hs-set-up-overlay #'my/fold-hideshow-set-up-overlay-fn) ; NOTE

  (my/defadvice my/fold--hideshow-ensure-mode-a (&rest _) ; NOTE
    "Ensure `hs-minor-mode' is enabled when we need it, no sooner or later."
    :before '(hs-toggle-hiding hs-hide-block hs-hide-level hs-show-all hs-hide-all)
    (unless (bound-and-true-p hs-minor-mode)
      (hs-minor-mode +1)))

  ;; extra folding support for more languages
  (unless (assq 't hs-special-modes-alist)
    (setq hs-special-modes-alist
          (append
           '((vimrc-mode "{{{" "}}}" "\"")
             (yaml-mode "\\s-*\\_<\\(?:[^:]+\\)\\_>"
                        ""
                        "#"
                        my/fold-hideshow-forward-block-by-indent-fn nil)
             (haml-mode "[#.%]" "\n" "/" my/fold-hideshow-haml-forward-sexp-fn nil)
             (ruby-mode "class\\|d\\(?:ef\\|o\\)\\|module\\|[[{]"
                        "end\\|[]}]"
                        "#\\|=begin"
                        ruby-forward-sexp)
             (matlab-mode "if\\|switch\\|case\\|otherwise\\|while\\|for\\|try\\|catch"
                          "end"
                          nil (lambda (_arg) (matlab-forward-sexp)))
             (nxml-mode "<!--\\|<[^/>]*[^/]>"
                        "-->\\|</[^/>]*[^/]>"
                        "<!--" sgml-skip-tag-forward nil))
           hs-special-modes-alist
           '((t))))))

(use-package evil-vimish-fold
  :commands
  (evil-vimish-fold/next-fold
   evil-vimish-fold/previous-fold
   evil-vimish-fold/delete
   evil-vimish-fold/delete-all
   evil-vimish-fold/create
   evil-vimish-fold/create-line)

  :init
  (setq vimish-fold-dir (expand-file-name "vimish-fold/" my/cache-dir))
  (setq vimish-fold-indication-mode 'right-fringe)

  :config
  (vimish-fold-global-mode +1))

