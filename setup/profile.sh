#!/bin/sh -e

echo "<profile.sh>"

echo "Include constants.sh in ~/.profile"
CONSTANTS_INCLUDE=". \"$VAGRANT_CONSTANTS_FILE\""

PROFILE_CURRENT=~/.profile
PROFILE_VAGRANT=/home/vagrant/.profile
PROFILE_ROOT=/root/.profile
grep -q "$CONSTANTS_INCLUDE" "$PROFILE_CURRENT" || echo "$CONSTANTS_INCLUDE" >> $PROFILE_CURRENT
grep -q "$CONSTANTS_INCLUDE" "$PROFILE_VAGRANT" || echo "$CONSTANTS_INCLUDE" >> $PROFILE_VAGRANT
grep -q "$CONSTANTS_INCLUDE" "$PROFILE_ROOT"    || echo "$CONSTANTS_INCLUDE" >> $PROFILE_ROOT

echo "</profile.sh>"
