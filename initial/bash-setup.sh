#!/bin/bash
WILKCONF=${WILKCONF:-"${HOME}/wilkconf"}
export WILKCONF

L="source '${WILKCONF}/etc/bashrc'"
if ! grep "^$L\$" ${HOME}/.bashrc &>/dev/null; then
    echo "$L" >> ~/.bashrc
fi

