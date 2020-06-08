;;; csharp

(use-package csharp-mode
  :defer t

  :mode
  ("\\.cs$" . csharp-mode))

(use-package dotnet
  :hook
  (csharp-mode . dotnet-mode))

(progn
  (defvar my/dotnet-mode-map (make-sparse-keymap))
  (defvar my/dotnet-goto-mode-map (make-sparse-keymap))
  (defvar my/dotnet-sln-mode-map (make-sparse-keymap))
  
  (general-def
    my/dotnet-goto-mode-map
    "p" #'dotnet-goto-csproj
    "s" #'dotnet-goto-sln)

  (general-def
    my/dotnet-sln-mode-map
    "l" #'dotnet-sln-list
    "n" #'dotnet-sln-new
    "r" #'dotnet-sln-remove)

  (general-def
    my/dotnet-mode-map
    "c ." #'dotnet-run
    "c b" #'dotnet-build
    "c c" #'dotnet-clean
    "c n" #'dotnet-new
    "c p" #'dotnet-add-package
    "c r" #'dotnet-add-reference
    "c t" #'dotnet-test
    "g"   #'(:keymap my/dotnet-goto-mode-map :wk "goto")
    "s"   #'(:keymap my/dotnet-sln-mode-map :wk "sln"))

  (my/local-leader-def
   '(normal visual)
   csharp-mode-map
   "c" #'(:keymap my/dotnet-mode-map :wk "dotnet-cli")))
