;; vars.el --- Define variables.	-*- lexical-binding: t -*-

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
;; Define variables.
;;

;;; Code:

;; fonts
(defvar my/fixed-latin-sans-font)
(defvar my/fixed-latin-serif-font)
(defvar my/variable-latin-sans-font)
(defvar my/variable-latin-serif-font)
(defvar my/fixed-jp-sans-font)
(defvar my/fixed-jp-serif-font)
(defvar my/variable-jp-sans-font)
(defvar my/variable-jp-serif-font)

(cond
 ((equal system-type 'gnu/linux)
  (setq my/fixed-latin-sans-font "Consolas NF")
  (setq my/fixed-latin-serif-font "")
  (setq my/variable-latin-sans-font "Ubuntu")
  (setq my/variable-latin-serif-font "Source Serif Pro")
  (setq my/fixed-jp-sans-font "MeiryoKe_Console")
  (setq my/fixed-jp-serif-font "Yu Mincho")
  (setq my/variable-jp-sans-font "Migu 1C")
  (setq my/variable-jp-serif-font "")
  )
 ((equal system-type 'darwin)
  (setq my/fixed-latin-sans-font "Consolas NF")
  (setq my/fixed-latin-serif-font "")
  (setq my/variable-latin-sans-font "")
  (setq my/variable-latin-serif-font "")
  (setq my/fixed-jp-sans-font "MeiryoKe_Console")
  (setq my/fixed-jp-serif-font "")
  (setq my/variable-jp-sans-font "")
  (setq my/variable-jp-serif-font "")))

;;; vars.el ends here
