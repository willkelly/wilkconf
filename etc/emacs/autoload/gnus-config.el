(setq mm-discouraged-alternatives '("text/html" "text/richtext")) ; prefer plaintext

;; some smtp stuff stolen from http://www.emacswiki.org/emacs/GnusMSMTP

(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/usr/bin/msmtp")
(setq message-sendmail-extra-arguments '("-a" "gmail"))
(setq mail-host-address "gmail.com")
(setq user-full-name "William Kelly")
(setq user-mail-address "the.william.kelly@gmail.com")

;; using cg-feed-msmtp to set msmtp stuff, using posting-style to set from address
(setq gnus-parameters
  ;;Use notthere id for all gmane news group postings
  '((".*rackspace.*"
     (posting-style
      (address "william.kelly@rackspace.com")
      (name "William Kelly")
;      (eval (setq message-sendmail-extra-arguments '("-a" "work")))
      (user-mail-address "william.kelly@rackspace.com")))
    (".*gmail.*"
     (posting-style
      (address "the.william.kelly@gmail.com")
      (name "William Kelly")
;      (eval (setq message-sendmail-extra-arguments '("-a" "gmail")))
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

;; Choose account label to feed msmtp -a option based on From header in Message buffer;
;; This function must be added to message-send-mail-hook for on-the-fly change of From address
;; before sending message since message-send-mail-hook is processed right before sending message.
(defun cg-feed-msmtp ()
  (if (message-mail-p)
      (save-excursion
	(let* ((from
		(save-restriction
		  (message-narrow-to-headers)
		  (message-fetch-field "from")))
	       (account
		(cond
		 ((string-match "william\.kelly@rackspace\.com" from) "work")
		 ((string-match "the\.william\.kelly@gmail\.com" from) "gmail"))))
	  (setq message-sendmail-extra-arguments (list '"-a" account)))))) ; the original form of this script did not have the ' before "a" which causes a very difficult to track bug --frozencemetery
(setq message-sendmail-envelope-from 'header)
(add-hook 'message-send-mail-hook 'cg-feed-msmtp)
