#Core shupernova functionality

export SHUPERNOVA_PATH="${SHUPERNOVA_PATH:-${HOME}/.shupernova}"

function os-env() {
    f="${SHUPERNOVA_PATH}/${1}"; shift
    cmd=$1; shift
    if [[ -n "${GPG_OPTS}" ]]; then
	e="${f}.gpg"
	! [[ -e "${e}" ]] && gpg ${GPG_OPTS} "${f}" && rm -f "${f}"
	( source <(gpg --batch -q -d ${e}) && $cmd "$@" )
    else
	( source "${f}"; $cmd "$@")
    fi
}

function shupernova() {
    os=$1; shift
    os-env $os nova "$@"
}

# Uncomment the following to enable encryption You'll need to have gpg
# installed, and you should probably set default-recipient-self and
# use_agent in ~/.gnupg/gpg.conf

## BEGIN ENCRYPTION BLOCK
export GPG_OPTS=${GPG_OPTS:-"-q -e"}
GPG_TTY=$(tty)
export GPG_TTY
if ! pgrep gpg-agent >/dev/null; then
    gpg-agent --daemon --enable-ssh-support \
	--write-env-file "${HOME}/.gpg-agent-info" &>/dev/null
fi

for f in "${HOME}/.gpg-agent-info" \
    "${HOME}/.gnupg/gpg-agent-info-${HOSTNAME}"; do
    if [ -f "${f}" ]; then
	. "${f}"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
    fi
done
## END ENCRYPTION BLOCK

# Uncomment the following to enable bash completion on shupernova environment
# nova completions flagrantly stolen from nova client tools
# someday I will make this better.

## BEGIN COMPLETION BLOCK
_nova_opts="" # lazy init
_nova_flags="" # lazy init
_nova_opts_exp="" # lazy init
_nova()
{
    local cur prev nbc cflags
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    if [ "x$_nova_opts" == "x" ] ; then
	nbc="`nova bash-completion | sed -e "s/  *-h  */ /" -e "s/  *-i  */ /"`"
	_nova_opts="`echo "$nbc" | sed -e "s/--[a-z0-9_-]*//g" -e "s/  */ /g"`"
	_nova_flags="`echo " $nbc" | sed -e "s/ [^-][^-][a-z0-9_-]*//g" -e "s/  */ /g"`"
	_nova_opts_exp="`echo "$_nova_opts" | tr ' ' '|'`"
    fi

    if [[ " ${COMP_WORDS[@]:2} " =~ " "($_nova_opts_exp)" " && "$prev" != "help" ]] ; then
	COMPLETION_CACHE=~/.novaclient/*/*-cache
	cflags="$_nova_flags "$(cat $COMPLETION_CACHE 2> /dev/null | tr '\n' ' ')
	COMPREPLY=($(compgen -W "${cflags}" -- ${cur}))
    else
	COMPREPLY=($(compgen -W "${_nova_opts}" -- ${cur}))
    fi
    return 0
}

function _shupernova() {
    local cur opts num
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    num=${#COMP_WORDS[@]}
    if [[ ${num} -eq 2 ]]; then
	# shupernova ...
	COMPREPLY=( $(compgen -W "$(ls $SHUPERNOVA_PATH | perl -pne 's/\.gpg$//')" -- ${cur}))
    elif [[ ${num} -gt 2 ]]; then
	# shupernova env ...
	_nova
    fi
}

function _os-env() {
    local cur opts num
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    num=${#COMP_WORDS[@]}
    if [[ ${num} -eq 2 ]]; then
	# os-env ...
	COMPREPLY=( $(compgen -W "$(ls $SHUPERNOVA_PATH | perl -pne 's/\.gpg$//')" -- ${cur}))
    elif [[ ${num} -eq 3 ]]; then
	# os-env env ...
	COMPREPLY=( $(compgen -c ${cur}) )
    else
	COMPREPLY=( $(compgen -f ${cur}) )
    fi

}
complete -F _shupernova shupernova
complete -F _os-env os-env
## END COMPLETION BLOCK
