(require 'netrc)
(defun offlineimap-get (host port token)
  (let* ((netrc (netrc-parse (expand-file-name "~/.authinfo.gpg")))
	 (hostentry (netrc-machine netrc host port port)))
    (when hostentry (netrc-get hostentry token))))

(defun offlineimap-get-password (host port)
  "helper for offlineimap"
  (offlineimap-get host port "password"))

(defun offlineimap-get-login (host port)
  "helper for offlineimap"
  (offlineimap-get host port "login"))
