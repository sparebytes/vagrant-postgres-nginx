# Vagrant w/ Postgres and NGINX

This is a Vagrant VM is designed to provide a development environment with PostgresSQL and Nginx 

#  Exposed Services
Description | Internal Address | Exposed Address | Folder
--- | --- | --- | ---
PostgreSQL | postgres://localhost:5432 | postgres://localhost:15432
Site 1 | http://localhost:90/ | http://localhost:90/

# Getting Started

## First Time Setup

```shell
vagrant up
vagrant ssh

# Fix file permissions in case they aren't working
chmod ogu+rwx /setup/**/*.sh
chmod ogu+rwx /tools/**/*.sh

# Ensure you have a database dump here: dbdump/latest.sql
/tools/db-reimport.sh
```

## Reprovision VM

If changes are made to the `Vagrantfile` then a reprovision is necessary: `vagrant provision`

## Useful CLI Scripts


### Database CLI Scripts

```shell
# Connect to main database via psql
/tools/db-psql.sh

# Restart PostgreSQL service
/tools/db-restart.sh

# Make backup of database
/tools/db-backup.sh [OLD_DB_NAME] [NEW_DB_NAME]

# Create blank database
/tools/db-create-blank.sh

# Dump database into /dbdump/ folder
/tools/db-dump.sh

# Import database from /dbdump/latest.sql
/tools/db-import-latest.sh

# Rename existing database and import /dbdump/latest.sql
/tools/db-reimport.sh

# Renames [CUR_DB_NAME] to something else and then copies [BACKUP_DB_NAME] as [CUR_DB_NAME]
/tools/db-restore.sh [BACKUP_DB_NAME] [CUR_DB_NAME]

# Kill all database connections to [DB_NAME]
/tools/db-kill-connections.sh [DB_NAME]

# Rename database
/tools/db-rename.sh [OLD_DB_NAME] [NEW_DB_NAME]
```

These scripts are broken for now:

```shell
# Watch database logs
/tools/db-log-watch.sh
# Watch database logs from this point on
/tools/db-log-watch-clean.sh
# Copy the latest database log into /mylogs/psql
/tools/db-log-swipe.sh
# Move all database logs into /mylogs/psql
/tools/db-log-archive.sh
```


# Manage Postgres

## Connecting

```shell
# Simple login as postgres
/tools/db-psql.sh

# If you know the database, user, and password then you may use this command instead:
psql -h localhost -d [DATABASE] -U [USERNAME] -W
``` 

## Import from dump

1. Place your database dump here: `/dbdump/latest.sql`
2. Import the database with this command:     

   `/tools/db-import-latest.sh`

