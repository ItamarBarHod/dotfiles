#!/usr/bin/env bash

WS_NAME="$FOCUSED_WORKSPACE"
WS_LENGTH=${#FOCUSED_WORKSPACE}

if [ "$WS_LENGTH" -le 2 ]; then
    if [[ "$WS_NAME" =~ ^[0-9]+$ ]]; then
        PADD_LEFT=10.6
    else
        PADD_LEFT=11
    fi
    sketchybar --set "$NAME" \
        label="$FOCUSED_WORKSPACE" \
        label.width=30 \
        label.align=center \
        label.padding_left=$PADD_LEFT
else
    sketchybar --set "$NAME" \
        label="$FOCUSED_WORKSPACE" \
        label.width=-1 \
        label.padding_left=12 \
        label.padding_right=12
fi
