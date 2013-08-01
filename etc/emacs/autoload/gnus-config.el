(setq mm-discouraged-alternatives '("text/html" "text/richtext")) ; prefer plaintext

;; some smtp stuff stolen from http://www.emacswiki.org/emacs/GnusMSMTP

(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/usr/bin/msmtp")
(setq message-sendmail-extra-arguments '("-a" "gmail"))
(setq mail-host-address "gmail.com")
(setq user-full-name "William Kelly")
(setq user-mail-address "the.william.kelly@gmail.com")

(setq gnus-parameters
  ;;Use notthere id for all gmane news group postings
  '((".*rackspace.*"
     (posting-style
      (address "william.kelly@rackspace.com")
      (name "William Kelly")
      (eval (setq message-sendmail-extra-arguments '("-a" "work")))
      (user-mail-address "william.kelly@rackspace.com")))
    (".*gmail.*"
     (posting-style
      (address "the.william.kelly@gmail.com")
      (name "William Kelly")
      (eval (setq message-sendmail-extra-arguments '("-a" "gmail")))
      (user-mail-address "the.william.kelly@gmail.com")))))

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
