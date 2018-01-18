#!/bin/sh -e

echo "<postgresql-database.sh>"

print_db_usage () {
  echo "Your PostgreSQL database has been setup and can be accessed on your local machine on the forwarded port (default: $POSTGRES_PORT_H)"
  echo "  Host: localhost"
  echo "  Guest VM Port: $POSTGRES_PORT_G"
  echo "  Exposed Port: $POSTGRES_PORT_H"
  echo "  Database: $POSTGRES_NAME"
  echo "  Username: $POSTGRES_USER"
  echo "  Password: $POSTGRES_PASS"
  echo ""
  echo "Admin access to postgres user via VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo ""
  echo "psql access to app database user via VM:"
  echo "  vagrant ssh"
  echo "  /tools/db-psql.sh"
  echo ""
  echo "Env variable for application development:"
  echo "  DATABASE_URL=postgresql://$POSTGRES_USER:$POSTGRES_PASS@localhost:$POSTGRES_PORT_H/$POSTGRES_NAME"
  echo ""
  echo "Local command to access the database via psql:"
  echo "  PGUSER=$POSTGRES_USER PGPASSWORD=$POSTGRES_PASS psql -h localhost -p $POSTGRES_PORT_G $POSTGRES_NAME"
}

echo "Create User and Database"
cat << EOF | sudo -u postgres psql
-- Create the database user:
CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASS';

-- Create the database:
CREATE DATABASE $POSTGRES_NAME WITH OWNER=$POSTGRES_USER
                                  LC_COLLATE='en_US.utf8'
                                  LC_CTYPE='en_US.utf8'
                                  ENCODING='UTF8'
                                  TEMPLATE=template0;

-- Connect to $POSTGRES_NAME database
\c $POSTGRES_NAME 

-- Grant access to $POSTGRES_USER user
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $POSTGRES_USER;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public to $POSTGRES_USER;
ALTER USER $POSTGRES_USER WITH superuser;
EOF

print_db_usage

echo "</postgresql-database.sh>"
