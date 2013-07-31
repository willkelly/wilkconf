#!/bin/bash

export WILKCONF="${WILKCONF:-${HOME}/wilkconf}"
AUTHFILE="${AUTHFILE:-${HOME}/.authinfo.gpg}"
declare -A services

function get-auth-info() {
    if [[ $# -eq 2 ]]; then
	declare -a machines=($(get-machine-for-service "${1}"))
	machine="${machines[@]}" #squash multiple return words into one
	port="$2"
	gpg -q --batch -d "${AUTHFILE}" | tr '\n\t' ' ' | tr -s ' ' \
	    | sed -e 's/\s*machine/\nmachine/g'  -e 's/\n*$/\n/' \
	    | grep "^machine ${machine} " | grep " port ${port}"
    fi
}

function get-machine-for-service() {
    if  [[ -f "${WILKCONF}/etc/authinfo" ]]; then
	source ${WILKCONF}/etc/authinfo
    fi
    echo ${services[${@}]:-${@}}
}
