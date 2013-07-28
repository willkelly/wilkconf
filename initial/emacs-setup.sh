#!/bin/bash

set -u

WILKCONF="${WILKCONF:-${HOME}/wilkconf}"
EMACS_DIR="${HOME}/.emacs.d"
EMACS_CONF="${EMACS_CONF:-${WILKCONF}/etc/emacs.el}"
if ! [[ -d "${EMACS_DIR}" ]]; then
    mkdir "${EMACS_DIR}"
fi

S="(load \"${EMACS_CONF}\")"
if ! grep "^${S}\$" "${EMACS_DIR}/init.el" &>/dev/null; then
    echo "${S}" >> "${EMACS_DIR}/init.el"
fi
