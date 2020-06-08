
(defvar my/emacs-distro (getenv "EMACS_DISTRO")
  "Emacs distribution name")

;; switch init file
(cond
 ;; vanilla-emacs
 ((or (string= my/emacs-distro "") (string= my/emacs-distro "vanilla-emacs"))
  (setq user-emacs-directory (expand-file-name "~/.emacs.d/")))

 ;; doom-emacs
 ((string= my/emacs-distro "doom-emacs")
 (setq user-emacs-directory
			(expand-file-name "~/.doom-emacs.d")))

 ;; spacemacs
 ((string= my/emacs-distro "spacemacs")
  (setq user-emacs-directory (expand-file-name "~/.spacemacs.d/")))

 ;; prelude-emacs
 ((string= my/emacs-distro "prelude-emacs")
  (setq user-emacs-directory (expand-file-name "~/.prelude-emacs.d")))

 ;; centaur-emacs
 ((equal my/emacs-distro "centaur-emacs")
  (setq user-emacs-directory (expand-file-name "~/.centaur-emacs.d/")))

 (t (error (concat my/emacs-distro "EMACS_DISTRO is not a valid value."))))

(load (expand-file-name "init.el" user-emacs-directory))
