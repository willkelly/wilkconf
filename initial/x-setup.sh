#!/bin/bash

L="${WILKCONF}/bin/xsession.sh"

if ! grep "^${L}\$" ~/.xsession &>/dev/null; then
    echo "${L}" >> ~/.xsession
fi
