#!/bin/bash

WILKCONF=${WILKCONF:-~/wilkconf}

#load xresources
for f in ${WILKCONF}/etc/Xresources/*; do
    xrdb -merge ${f}
done
