#!/bin/sh

APPNAME="$1"
SUMMARY="$2"
BODY="$3"
ICON="$4"
URGENCY="$5"
emacsclient -n --eval "(message \"${APPNAME}/${SUMMARY}: $BODY\")"
