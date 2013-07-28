#!/bin/bash

PATH="$(dirname $0):${PATH}"
WILKCONF=${WILKCONF:-"${HOME}/wilkconf"}
export WILKCONF

pushd $(dirname $0) &>/dev/null
./keyboard-setup.sh
./git-setup.sh
./bash-setup.sh
./x-setup.sh
./emacs-setup.sh
popd &>/dev/null
