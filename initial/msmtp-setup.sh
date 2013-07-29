#!/bin/bash

set -u

WILKCONF="${WILKCONF:-${HOME}/wilkconf}"

if ! dpkg -l msmtp; then
    sudo apt-get install -y msmtp
fi

if ! [[ -f "${HOME}/.msmtprc" ]]; then
    ln -s "${WILKCONF}/etc/msmtprc" "${HOME}/.msmtprc"
fi
