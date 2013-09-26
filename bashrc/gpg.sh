#!/bin/bash

## BEGIN ENCRYPTION BLOCK
export GPG_OPTS=${GPG_OPTS:-"-q -e"}
GPG_TTY=$(tty)
export GPG_TTY
if ! pgrep gpg-agent >/dev/null; then
    gpg-agent --daemon --enable-ssh-support \
        --write-env-file "${HOME}/.gpg-agent-info" &>/dev/null
fi

for f in "${HOME}/.gpg-agent-info" "${HOME}/.gnupg/gpg-agent-info-${HOSTNAME}"; do
    if [ -f "${f}" ]; then
	. "${f}"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
    fi
done

## END ENCRYPTION BLOCK

