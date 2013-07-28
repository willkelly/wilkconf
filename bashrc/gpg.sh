#!/bin/bash

## BEGIN ENCRYPTION BLOCK
GPG_OPTS=${GPG_OPTS:-"-q -e"}
GPG_TTY=$(tty)
export GPG_TTY
if ! pgrep gpg-agent >/dev/null; then
    gpg-agent --daemon --enable-ssh-support \
        --write-env-file "${HOME}/.gpg-agent-info" &>/dev/null
fi
if [ -f "${HOME}/.gpg-agent-info" ]; then
    . "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
fi
## END ENCRYPTION BLOCK
