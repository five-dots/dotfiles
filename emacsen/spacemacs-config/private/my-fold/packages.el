;;; packages.el --- my-fold layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: shun <shun@x1>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst my-fold-packages
  '(
    evil-vimish-fold
    ))

(defun my-fold/init-evil-vimish-fold ()
  (use-package evil-vimish-fold
    :commands (evil-vimish-fold/next-fold
               evil-vimish-fold/previous-fold
               evil-vimish-fold/create
               evil-vimish-fold/create-line
               evil-vimish-fold/delete
               evil-vimish-fold/delete-all)
    :init
    (setq vimish-fold-dir
          (expand-file-name "vimish-fold/" spacemacs-cache-directory))
    (setq vimish-fold-indication-mode 'right-fringe)
    (bind-keys
     :map evil-normal-state-map
     ("zF" . evil-vimish-fold/create-line)
     ("zd" . evil-vimish-fold/delete)
     ("zE" . evil-vimish-fold/delete-all))
    (bind-keys
     :map evil-visual-state-map
     ("zf" . evil-vimish-fold/create))
    (vimish-fold-global-mode +1)))

(defun my-fold/init-hideshow ()
  (use-package hideshow
    :commands (hs-toggle-hiding
               hs-hide-block
               hs-hide-level
               hs-show-all
               hs-hide-all)
    :config
    (setq hs-hide-comments-when-hiding-all nil)
    ;; Nicer code-folding overlays (with fringe indicators)
    (setq hs-set-up-overlay #'+fold-hideshow-set-up-overlay-fn)

    (defadvice! +fold--hideshow-ensure-mode-a (&rest _)
      "Ensure `hs-minor-mode' is enabled."
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
                          +fold-hideshow-forward-block-by-indent-fn nil)
               (haml-mode "[#.%]" "\n" "/" +fold-hideshow-haml-forward-sexp-fn nil)
               (ruby-mode "class\\|d\\(?:ef\\|o\\)\\|module\\|[[{]"
                          "end\\|[]}]"
                          "#\\|=begin"
                          ruby-forward-sexp)
               (enh-ruby-mode "class\\|d\\(?:ef\\|o\\)\\|module\\|[[{]"
                              "end\\|[]}]"
                              "#\\|=begin"
                              enh-ruby-forward-sexp nil)
               (matlab-mode "if\\|switch\\|case\\|otherwise\\|while\\|for\\|try\\|catch"
                            "end"
                            nil (lambda (_arg) (matlab-forward-sexp)))
               (nxml-mode "<!--\\|<[^/>]*[^/]>"
                          "-->\\|</[^/>]*[^/]>"))
             hs-special-modes-alist
             '((t)))))))

