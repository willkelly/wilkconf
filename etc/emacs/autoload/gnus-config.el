(setq mm-discouraged-alternatives '("text/html" "text/richtext"))
(load "image")
;; some smtp stuff stolen from http://www.emacswiki.org/emacs/GnusMSMTP
(setq gnus-novice-user nil)
(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/usr/bin/msmtp")
;(setq message-sendmail-extra-arguments '("-a" "gmail"))
(setq mail-host-address "planet.com")
(setq user-full-name "William Kelly")
(setq user-mail-address "william.kelly@planet.com")
(setq message-kill-buffer-on-exit t)
;; using cg-feed-msmtp to set msmtp stuff, using posting-style to set from address
(setq gnus-parameters
  ;;Use notthere id for all gmane news group postings
  '((".*gmail.*"
     (posting-style
      (address "william.kelly@planet.com")
      (name "William Kelly")
;      (eval (setq message-sendmail-extra-arguments '("-a" "gmail")))
      (user-mail-address "william.kelly@planet.com")))))

(setq gnus-select-method '(nntp "news.gnus.org"))
(setq gnus-secondary-select-methods '((nnimap "gmail"
		(nnimap-stream shell)
		(nnimap-shell-program
		 "/usr/lib/dovecot/imap -o mail_location=maildir:/home/wilk/Maildir/william.kelly@planet.com"))))
;	(nntp "news.gmane.org")
;	(nntp "news.gwene.org")))

(require 'epg-config)
(setq mml2015-use 'epg

      mml2015-verbose t
      epg-user-id "William Kelly <william.kelly@planet.com>"
      mml2015-encrypt-to-self t
      mml2015-always-trust nil
      mml2015-cache-passphrase t
      mml2015-passphrase-cache-expiry '36000
      mml2015-sign-with-sender t
      
       gnus-message-replyencrypt t
       gnus-message-replysign t
       gnus-message-replysignencrypted t
       gnus-treat-x-pgp-sig t

;;       mm-sign-option 'guided
;;       mm-encrypt-option 'guided
       mm-verify-option 'always
       mm-decrypt-option 'always

       gnus-buttonized-mime-types
       '("multipart/alternative"
         "multipart/encrypted"
         "multipart/signed")

       epg-debug t ;;  then read the *epg-debug*" buffer
       )


(add-hook 'message-setup-hook 'mml-secure-sign-pgpmime)
(eval-after-load "gnus"
  '(progn
     (define-key gnus-summary-mode-map (kbd "v d")
       (lambda ()
	 (interactive)
	 (gnus-summary-delete-article)))))

(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/usr/bin/msmtp"
      mail-specify-envelope-from nil
      message-sendmail-f-is-evil t)
(setq gnus-permanently-visible-groups ".*")
