;; const.el --- Define constants.	-*- lexical-binding: t -*-

;; Copyright (C) 2019-2020 Shun Asai

;; Author: Shun Asai <syun.asai@gmail.com>
;; URL: https://github.com/five-dots/dotfiles

;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;

;;; Commentary:
;;
;; Define constants.
;;

;;; Code:

;; directories
(defvar my/emacsen-dir (expand-file-name
                        "~/Dropbox/repos/github/five-dots/dotfiles/emacsen"))

(defvar my/elisp-dir (expand-file-name "elisp" my/emacsen-dir))

(defvar my/snippets-dir (expand-file-name "snippets" my/emacsen-dir))

(defvar my/cache-dir (expand-file-name ".cache" user-emacs-directory))

;; predicates
(defconst my/linux-p (eq system-type 'gnu/linux))

(defconst my/mac-p (eq system-type 'darwin))

;;; const.el ends here
