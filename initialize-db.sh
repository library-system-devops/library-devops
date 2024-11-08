#!/bin/bash
set -e

# Check if the database is already initialized
if [ ! -d "/var/lib/mysql/library_system" ]; then
  echo "Initializing database..."
  mysql < /docker-entrypoint-initdb.d/initial_setup.sql
else
  echo "Database already initialized."
fi