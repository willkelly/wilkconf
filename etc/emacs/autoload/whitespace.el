(require 'whitespace)
(setq-default whitespace-style '(face trailing lines empty
indentation::space space-before-tab::space space-after-tab::space))
(setq-default whitespace-line-column 80)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-whitespace-mode 1)
(setq-default c-default-style "k&r"
              c-basic-offset 4
              tab-width 8
              indent-tabs-mode nil)
