(add-hook 'go-mode-hook
          (lambda ()
              (add-hook 'before-save-hook 'gofmt-before-save)
                          (setq tab-width 4)
                                      (setq indent-tabs-mode 1)))

(add-to-list 'load-path "/home/wilk/src/go-mode.el")
(require 'go-mode-autoloads)
