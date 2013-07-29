; These are my minor ido tweaks
(ido-mode t)
(define-key (cdr ido-minor-mode-map-entry) [remap write-file] nil)
(unless (fboundp 'sixth)
  (defun sixth (l) "returns the sixth element of a list"
    (nth 5 l)))
 
;configure ido
;; my-backup-dir defined in 00only-poop-in-toilet.el
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10
      ido-save-directory-list-file (join-dirs my-backup-dir "ido.hist")
      ido-default-file-method 'selected-window)
 
; not exactly ido, but hey
(icomplete-mode +1)
(set-default 'imenu-auto-rescan t)
 
; Sort by mtime (from emacs wiki)
(add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
(add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)
(defun ido-sort-mtime ()
  (setq ido-temp-list
        (sort ido-temp-list
              (lambda (a b)
                (time-less-p
                 (sixth (file-attributes (concat ido-current-directory b)))
                 (sixth (file-attributes (concat ido-current-directory a)))))))
  (ido-to-end  ;; move . files to end (again)
   (delq nil (mapcar
              (lambda (x) (and (char-equal (string-to-char x) ?.) x))
              ido-temp-list))))
