#!/bin/bash

if ! dpkg -l dovecot-imapd &>/dev/null; then
    sudo apt-get install -y dovecot-imapd
    sudo /etc/init.d/dovecot stop
    echo 'ENABLED=0' | sudo tee -a /etc/default/dovecot
    sudo sed -i 's/^mail_location = .*/mail_location = maildir:~\/Maildir\/%u/g' \
	/etc/dovecot/conf.d/10-mail.conf
elif ! grep 'mail_location = maildir:~\/Maildir\/%u' \
	/etc/dovecot/conf.d/10-mail.conf &>/dev/null; then
    echo "Dovecot already installed.  Manual configuration may be necessary for gnus." 1>&2
fi
