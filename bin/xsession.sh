#!/bin/bash
set -x
set -u

export WILKCONF=${WILKCONF:-~/wilkconf}

#load xresources
for f in ${WILKCONF}/etc/Xresources/*; do
    xrdb -merge ${f}
done

for f in ${WILKCONF}/etc/Xsession/*.sh; do
    source $f
    mkdir -p /tmp/${f}
done
touch /tmp/ran
