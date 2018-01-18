#!/bin/sh -e

# Fix file permissions
chmod ogu+rwx /setup/**/*.sh
chmod ogu+rwx /tools/**/*.sh

# Constants
. /setup/config/constants.sh

## Apt-Get Update
echo "Apt-Get Update"
apt-get update > /dev/null

# Scripts
sh -e /setup/profile.sh
sh -e /setup/git.sh
sh -e /setup/nginx.sh
sh -e /setup/postgresql-server.sh
sh -e /setup/postgresql-database.sh
