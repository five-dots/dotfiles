
;; Setup straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
          "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
          'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Do not load
;; https://archive.casouri.cat/note/2020/painless-transition-to-portable-dumper/index.html
;;
;; (use-package evil)
;; (use-package magit)
;; (use-package winner)
;; (use-package undo-tree)
;; (use-package magit)
;; (use-package magit-todos)
;; (use-package tramp) ; Error: unsupported object type in dump: mutex

;; [Treemacs] Warning: couldn’t find hl-line-mode’s background color for icons, falling back on unspecified-bg.
;; (use-package treemacs)
;; (use-package treemacs-projectile)
;; (use-package treemacs-icons-dired)
;; (use-package treemacs-persp)
;; (use-package treemacs-magit)
;; (use-package dap-ui :straight nil :load-path "straight/build/dap-mode") ; (require 'lsp-treemacs)


;; Libraries
(use-package dash)
(use-package f)
(use-package s)

;; Org
(use-package org)

;; Core
(use-package esup)
(use-package general)
(use-package exec-path-from-shell)
(use-package transient)
(use-package prescient)
(use-package recentf) ; require later to run recentf ?
(use-package recentf-ext)
(use-package undo-tree)
(use-package restart-emacs)
(use-package smartparens)
(use-package projectile)
(use-package helpful)
(use-package google-this)
(use-package undohist)
(use-package crontab-mode)
(use-package quickrun)
(use-package vc)
(use-package visual-regexp)
(use-package visual-regexp-steroids)
(use-package link-hint) ; Link hinting with avy
(use-package expand-region)

;; UI
(use-package all-the-icons)
(use-package dashboard
  :init
  (dashboard-setup-startup-hook))
(use-package doom-themes
  :init
  (load-theme 'doom-one t t)
  :config
  (doom-themes-treemacs-config)
  (doom-themes-org-config))
(use-package doom-modeline)

(use-package hydra)
(use-package hide-mode-line)
(use-package which-key)
(use-package hl-todo)
(use-package beacon)
(use-package rainbow-delimiters)
(use-package highlight-numbers)
(use-package highlight-indent-guides)
(use-package highlight-parentheses)
(use-package page-break-lines)
(use-package centaur-tabs)
(use-package window-purpose)
(use-package hideshow)
(use-package winum)
(use-package ace-window)

;; Ivy
(use-package ivy)
(use-package ivy-prescient)
(use-package ivy-posframe)
(use-package ivy-rich)
(use-package ivy-hydra)
(use-package counsel)
(use-package counsel-projectile)
(use-package swiper)
(use-package amx)
(use-package flx) ; fuzzy search
(use-package all-the-icons-ivy-rich)

;; Company
(use-package company)
(use-package company-quickhelp)
(use-package company-prescient)
(use-package company-lsp)
(use-package company-anaconda)
(use-package company-stan)

;; Snippets
(use-package yasnippet)
(use-package yasnippet-snippets)

;; Eshell
(use-package eshell)

;; Flycheck
(use-package flycheck)
(use-package flycheck-stan)
(use-package flycheck-posframe)

;; LSP
(use-package lsp-mode)
(use-package lsp-ui)
(use-package lsp-python-ms)
(use-package ccls)
(use-package dap-mode)
(use-package dap-python :straight nil :load-path "straight/build/dap-mode")
(use-package dap-gdb-lldb :straight nil :load-path "straight/build/dap-mode")

;; Org
(use-package org-download)
(use-package ob-async)

;; Emacs-lisp
(use-package lispxmp)
(use-package nameless)
(use-package overseer)

;; ESS
(use-package ess)
(use-package ess-R-data-view)
(use-package ess-smart-equals)
(use-package ess-r-spreadsheet
  :straight nil
  :load-path "~/Dropbox/repos/github/five-dots/ess-r-spreadsheet")

;; Stan
(use-package stan-mode)
(use-package stan-snippets)
(use-package eldoc-stan)

;; Python
(use-package python)
(use-package anaconda-mode)
(use-package jupyter)
(use-package ob-ipython)
(use-package ein)

;; Apps
(use-package calfw)
(use-package calfw-org)
(use-package calfw-ical)
(use-package org-gcal)

;; Japanse
(use-package migemo)
(use-package avy-migemo)
(use-package mozc)
(use-package pangu-spacing)
(use-package japanese-holidays)

;; Load theme but not enable
;; (load-theme 'doom-one t t)

;; Dump file
(dump-emacs-portable (expand-file-name "emacs.pdmp" user-emacs-directory))
