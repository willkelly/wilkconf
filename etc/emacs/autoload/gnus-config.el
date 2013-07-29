(setq mm-discouraged-alternatives '("text/html" "text/richtext")) ; prefer plaintext

(setq gnus-select-method '(nntp "news.gnus.org"))
(setq gnus-secondary-select-methods
      '((nnimap "gmail"
                (nnimap-stream shell)
                (nnimap-shell-program
		 "USER=the.william.kelly@gmail.com
                 /usr/lib/dovecot/imap"))
	(nnimap "rackspace"
		(nnimap-stream shell)
		(nnimap-shell-program
		 "USER=william.kelly@rackspace.com
                 /usr/lib/dovecot/imap"))))
