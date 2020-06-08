;;; flycheck

(use-package flycheck
  ;; Supported Languages
  ;; http://www.flycheck.org/en/latest/languages.html

  :hook
  (ess-r-mode . flycheck-mode)

  :config
  ;; default (save idle-change new-line mode-enabled)
  (setq flycheck-check-syntax-automatically '(save mode-enabed))

  (setq flycheck-lintr-linters
        "with_defaults(
           line_length_linter(length = 80L),
           implicit_integer_linter,
           T_and_F_symbol_linter,
           todo_comment_linter,
           object_name_linter = NULL,
           cyclocomp_linter = NULL,
           pipe_continuation_linter = NULL,
           commented_code_linter = NULL
        )")
  )
