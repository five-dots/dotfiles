;;; dot_emacs.el ---                                 -*- lexical-binding: t; -*-
;;; Select emacs config file directory depending on emacs being run

;; https://gist.github.com/kaz-yos/0c7bc69d3df6a9199b4db715b9455a30
;; http://emacs.stackexchange.com/questions/19936/running-spacemacs-alongside-regular-emacs-how-to-keep-a-separate-emacs-d

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.
;; (package-initialize)

;;; Check the current executable file and assign the appropriate user directory.
;; The unless is to avoid executing this script twice.
(unless (boundp 'dot-emacs-loaded)
  (let ((emacs-exec-path (expand-file-name invocation-name invocation-directory)))
    (cond
     ((string-match ".*vanilla-emacs*" (downcase emacs-exec-path))
      (setq user-emacs-directory "~/.vanilla-emacs.d/"))
     ((string-match ".*spacemacs*" (downcase emacs-exec-path))
      (setq user-emacs-directory "~/.spacemacs.d/"))
     ((string-match ".*doom-emacs*" (downcase emacs-exec-path))
      (setq user-emacs-directory "~/.doom-emacs.d/")))
    ;; Load init.el under user directory.
    (load (expand-file-name "init.el" user-emacs-directory))
    ;; Create a variable to indicate this script has been run.
    (defvar dot-emacs-loaded t)))
