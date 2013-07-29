#!/bin/bash

set -u

WILKCONF="${WILKCONF:-${HOME}/wilkconf}"

if ! dpkg -l offlineimap &>/dev/null; then
    sudo apt-get install -y offlineimap
fi

if ! [[ -f "${HOME}/.offlineimaprc" ]]; then
    ln -s "${WILKCONF}/etc/offlineimap/offlineimaprc" \
	"${HOME}/.offlineimaprc"
fi

if ! [[ -f "${HOME}/.offlineimap.py" ]]; then
    ln -s "${WILKCONF}/etc/offlineimap/offlineimapconf.py" \
	"${HOME}/.offlineimap.py"
fi
