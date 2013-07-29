;; from emacs-wiki
(defun yank-to-x-clipboard ()
  (interactive)
  (if (region-active-p)
        (progn
	  (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
	  (shell-command-on-region (region-beginning) (region-end) "xsel -i")
	  (shell-command-on-region (region-beginning) (region-end) "xsel -i -s")
	  (message "Yanked region to clipboard!")
	  (deactivate-mark))
    (message "No region active; can't yank to clipboard!")))

(global-set-key [f8] 'yank-to-x-clipboard)
