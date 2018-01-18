#!/bin/sh -e
cdir="${0%/*}"
$cdir/db-kill-connections.sh
$cdir/db-rename.sh
$cdir/db-create-blank.sh
$cdir/db-import-latest.sh