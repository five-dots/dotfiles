
(evil-define-key
  '(motion) 'global
  (kbd "<home>")  #'evil-first-non-blank-of-visual-line
  (kbd "<next>")  #'evil-forward-paragraph
  (kbd "<prior>") #'evil-backward-paragraph
  (kbd "<end>")   #'evil-end-of-visual-line
  "j"  #'evil-next-visual-line
  "k"  #'evil-previous-visual-line
  "gj" #'evil-next-line
  "gk" #'evil-previous-line)

;; window navigation
(evil-define-key '(motion) 'global
  (kbd "C-M-h") #'evil-window-left
  (kbd "C-M-j") #'evil-window-down
  (kbd "C-M-k") #'evil-window-up
  (kbd "C-M-l") #'evil-window-right)
