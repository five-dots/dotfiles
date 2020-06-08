
(bind-keys
 :map comint-mode-map
 ("C-M-h" . evil-window-left)
 ("C-M-j" . evil-window-down)
 ("C-M-k" . evil-window-up)
 ("C-M-l" . evil-window-right)
 ("C-l"   . comint-clear-buffer))
