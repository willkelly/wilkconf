#!/bin/bash

if ! dpkg -l dovecot-imapd &>/dev/null; then
    sudo apt-get install -y dovecot-imapd
    sudo /etc/init.d/dovecot stop
    echo 'ENABLED=0' | sudo tee -a /etc/default/dovecot
    echo "Dovecot already installed.  Manual configuration may be necessary for gnus." 1>&2
fi
