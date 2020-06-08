
(bind-keys
 :map company-active-map
 ("<tab>" . company-complete-selection)
 ("M-." . company-filter-candidates)
 ("M-/" . company-search-candidates)
 ("M-j" . company-select-next)
 ("M-k" . company-select-previous)
 ("M-d" . company-next-page)
 ("M-i" . company-show-doc-buffer)
 ("M-p" . company-quickhelp-manual-begin)
 ("M-u" . company-previous-page)
 ("M-w" . company-show-location)
 ("M-c" . counsel-company))

(evil-define-key 'insert 'global
  (kbd "M-,") 'company-manual-begin)
