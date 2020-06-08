
(add-to-list 'load-path (expand-file-name "~/repos/org-mode/lisp"))

(require 'org)

(setq my/dumped-load-path load-path)

;; Dump file
(dump-emacs-portable (expand-file-name "~/.emacs-pdump.d/org.pdmp"))
