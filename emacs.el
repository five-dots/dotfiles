;;; dot_emacs.el ---                                 -*- lexical-binding: t; -*-
;;; Select emacs config file directory depending on emacs being run

;; https://gist.github.com/kaz-yos/0c7bc69d3df6a9199b4db715b9455a30
;; http://emacs.stackexchange.com/questions/19936/running-spacemacs-alongside-regular-emacs-how-to-keep-a-separate-emacs-d

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

;;; Check the current executable file and assign the appropriate user directory.
;; The unless is to avoid executing this script twice.
(unless (boundp 'dot-emacs-loaded)
  (let ((emacs-exec-path (expand-file-name
                          ;; The program name that was used to run Emacs.
                          invocation-name
                          ;; The directory in which the Emacs executable was found, to run it.
                          invocation-directory)))
    ;;
    ;; Check if executable path contains spacemacs
    ;; Duplicate Emacs.app and rename it to Spacemacs.app
    (when (string-match ".*spacemacs*" (downcase emacs-exec-path))
      ;; If so, change user-emacs-directory to spacemacs one
      ;; Directory beneath which additional per-user Emacs-specific files are placed.
      ;;
      ;; Clone spacemacs configurations into ~/.spacemacs.d.
      ;; An empty ~/.spacemacs file is also necessary.
      ;; As of 2016-12-25, only the develop branch is compatible.
      (setq user-emacs-directory "~/.spacemacs.d/"))
    ;;
    ;; Load init.el under user directory.
    (load (expand-file-name "init.el" user-emacs-directory))
    ;; Create a variable to indicate this script has been run.
    (defvar dot-emacs-loaded t)))
