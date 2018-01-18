#!/bin/bash -e

echo "Creating blank database: ${POSTGRES_NAME}"

cat << EOF | sudo -u postgres psql
-- Create empty database
create database "${POSTGRES_NAME}";

-- Assign ${POSTGRES_USER} user to ${POSTGRES_NAME} database
alter database "${POSTGRES_NAME}" owner to "${POSTGRES_USER}";
EOF

